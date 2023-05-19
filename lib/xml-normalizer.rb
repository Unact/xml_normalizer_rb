require 'nokogiri'

class XMLNormalizer
  attr_accessor :doc
  def initialize(input)
    if input.is_a? String
      @doc = Nokogiri::XML(input, nil, 'utf-8', &:noblanks)
    elsif input.is_a? Nokogiri::XML::Document
      @doc = input
      @doc.encoding = 'utf-8'
    end
    @_index = 0
  end

  def to_s
    @doc.to_xml(save_with: 0 | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS)
  end

  def remove_processing_instructions
    @doc.xpath('//processing-instruction()').remove
    self
  end

  def remove_spaces_characters
    self
  end

  def remove_unsed_prefixes
    res = create_doc(@doc)
    remove_unsed_prefixes_from_element(res, res, [@doc.root]).each do |inner_node|
    res << inner_node
       end
    @doc = res
    self
  end

  def next_index
    @_index += 1
  end

  def remove_unsed_prefixes_from_element(doc, target, node_set, nss = nil)
    nss = Hash.new{|h,k| h[k] = format('ns%{index}', index: next_index)} unless nss

    result = []
    node_set.each do |node|
      namespaces = nss.dup
      _t = node.class.new(node.text? ? node.to_s : node.name, Nokogiri::XML::Document.new(target))
      ns1 = _t.namespace = _t.add_namespace_definition(namespaces[node.namespace.href], node.namespace.href) if node.namespace
      if !(attrs = sort_helper(node, doc, namespaces)).empty?
        attrs.each do |object|
          a = object[0]
          namespc = object[1]
          if namespc
            _t.namespace = _t.add_namespace_definition(namespc.prefix, namespc.href)
            _t.set_attribute(format('%s:%s', namespc.prefix, a.name), a.value)
          else
            _t.set_attribute(a.name, a.value)
          end
          _t.namespace =  ns1
        end
      end
      temp = remove_unsed_prefixes_from_element(doc, _t, node.children, namespaces)
      temp.each do |inner_node|
        _t << inner_node
      end

      result << _t
    end
    result
  end

  def sort_helper(node, doc, namespaces)
    attrs = []
    node.attribute_nodes.sort_by { |a| a.namespace.nil? ? (a = format('x:///%s', a.name)) : (a = format('%s/%s', a.namespace.href, a.name)) }.each do |attribute|
      namespace = nil

      if attribute.namespace
        namespace = node.namespace_definitions.select { |a| a.prefix == namespaces[attribute.namespace.href] }.first
        if !namespace
          namespace = node.add_namespace_definition(namespaces[attribute.namespace.href], attribute.namespace.href)
        end
      end

      tmp = Nokogiri::XML::Attr.new(doc, attribute.name)
      tmp.value = attribute.value

      attrs << [tmp, namespace]
    end

    attrs
  end

  private

  def create_doc(pattern_doc)
    doc = Nokogiri::XML::Document.new
    doc.encoding = pattern_doc.encoding
    doc
  end
end

require_relative 'xml-normalizer/version'
