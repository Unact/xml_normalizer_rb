# ~*~ encoding: utf-8 ~*~

require 'spec_helper'

describe "qq" do
  it 'step 1' do
    input = %Q{<?xml version="1.0" encoding="UTF-8" ?>
<?xml-stylesheet type="text/css" href="style.css" ?>
<qwe xmlns="http://test">
<myns:rty xmlns:myns="http://yes">yes!</myns:rty>
<iop value="yes, yes!"/>
</qwe>}
    output = %Q{<qwe xmlns="http://test"><myns:rty xmlns:myns="http://yes">yes!</myns:rty><iop value="yes, yes!"></iop></qwe>
}
    expect(XMLNormalizer.new(input).remove_processing_instructions.to_s).to eql(output)
  end

  it 'step 2' do
    input = %Q{<qwe xmlns="http://test">
<myns:rty xmlns:myns="http://yes">yes!</myns:rty>
<iop value="yes, yes!"/>
</qwe>}
    output = %Q{<qwe xmlns="http://test"><myns:rty xmlns:myns="http://yes">yes!</myns:rty><iop value="yes, yes!"></iop></qwe>
}
    expect(XMLNormalizer.new(input).remove_spaces_characters.to_s).to eql(output)
  end


  it 'step 3' do
    input = %Q{<qwe xmlns="http://test">
<myns:rty xmlns:myns="http://yes">yes!</myns:rty>
<iop value="yes, yes!"/>
</qwe>}
    output = %Q{<qwe xmlns="http://test"><myns:rty xmlns:myns="http://yes">yes!</myns:rty><iop value="yes, yes!"></iop></qwe>
}
    expect(XMLNormalizer.new(input).remove_spaces_characters.to_s).to eql(output)
  end

  it 'step 4' do
    input=%Q{<elementOne xmlns="http://test/1" xmlns:qwe="http://test/2" xmlns:asd="http://test/3" xmlns:sdf="http://test/5">
<qwe:elementTwo>
<asd:elementThree>
<elementFour> z x c </elementFour>
<qqq:elementFive xmlns:qqq="http://test/2" xmlns:ccc="http://test/4"> w w w </qqq:elementFive>
</asd:elementThree>
<asd:elementSix>eee</asd:elementSix>
</qwe:elementTwo>
</elementOne>
}
    output=%Q{<ns1:elementOne xmlns:ns1="http://test/1"><ns2:elementTwo xmlns:ns2="http://test/2"><ns3:elementThree xmlns:ns3="http://test/3"><ns1:elementFour> z x c </ns1:elementFour><ns2:elementFive> w w w </ns2:elementFive></ns3:elementThree><ns4:elementSix xmlns:ns4="http://test/3">eee</ns4:elementSix></ns2:elementTwo></ns1:elementOne>
}
    expect(XMLNormalizer.new(input).remove_unsed_prefixes.to_s).to eql(output)
  end

  it 'step 5' do
    input=%Q{<elementOne xmlns="http://test/1" xmlns:qwe="http://test/2" xmlns:asd="http://test/3">
<qwe:elementTwo>
<asd:elementThree>
<elementFour> z x c </elementFour>
<qqq:elementFive xmlns:qqq="http://test/2"> w w w </qqq:elementFive>
</asd:elementThree>
<asd:elementSix>eee</asd:elementSix>
</qwe:elementTwo>
</elementOne>
}
    output=%Q{<ns1:elementOne xmlns:ns1="http://test/1"><ns2:elementTwo xmlns:ns2="http://test/2"><ns3:elementThree xmlns:ns3="http://test/3"><ns1:elementFour> z x c </ns1:elementFour><ns2:elementFive> w w w </ns2:elementFive></ns3:elementThree><ns4:elementSix xmlns:ns4="http://test/3">eee</ns4:elementSix></ns2:elementTwo></ns1:elementOne>
}
    expect(XMLNormalizer.new(input).remove_unsed_prefixes.to_s).to eql(output)
  end
  it 'step 6' do
    input = %Q{<qwe xmlns="http://test">
<myns:rty xmlns:myns="http://yes">yes!</myns:rty>
<iop value="yes, yes!" />
</qwe>}
    output = %Q{<ns1:qwe xmlns:ns1="http://test"><ns2:rty xmlns:ns2="http://yes">yes!</ns2:rty><ns1:iop value="yes, yes!"></ns1:iop></ns1:qwe>
}
    expect(XMLNormalizer.new(input).remove_unsed_prefixes.to_s).to eql(output)
  end
  it 'step 7' do
    input = %Q{<qwe xmlns="http://test" attrB="val2" attrA="val1">
<iop value="yes, yes!"></iop>
</qwe>
}
    output = %Q{<ns1:qwe xmlns:ns1="http://test" attrA="val1" attrB="val2"><ns1:iop value="yes, yes!"></ns1:iop></ns1:qwe>
}
    expect(XMLNormalizer.new(input).remove_unsed_prefixes.to_s).to eql(output)
  end
  it 'step 8' do
    input = %Q{<elementOne xmlns="http://test/1" xmlns:qwe="http://test/2" xmlns:asd="http://test/3">
<qwe:elementTwo>
<asd:elementThree xmlns:wer="http://test/a" xmlns:zxc="http://test/0" wer:attZ="zzz" attB="bbb" attA="aaa" zxc:attC="ccc" asd:attD="ddd" asd:attE="eee"
qwe:attF="fff"/>
</asd:elementThree>
</qwe:elementTwo>
</elementOne>
}
    output = %Q{<ns1:elementOne xmlns:ns1="http://test/1"><ns2:elementTwo xmlns:ns2="http://test/2"><ns3:elementThree xmlns:ns3="http://test/3" xmlns:ns4="http://test/0" xmlns:ns5="http://test/a" ns4:attC="ccc" ns2:attF="fff" ns3:attD="ddd" ns3:attE="eee" ns5:attZ="zzz" attA="aaa" attB="bbb"></ns3:elementThree></ns2:elementTwo></ns1:elementOne>
}
    expect(XMLNormalizer.new(input).remove_unsed_prefixes.to_s).to eql(output)
  end

  it 'работает с Nokogiri::XML::Document' do

    input = %Q{<elementOne xmlns="http://test/1" xmlns:qwe="http://test/2" xmlns:asd="http://test/3">
<qwe:elementTwo>
<asd:elementThree xmlns:wer="http://test/a" xmlns:zxc="http://test/0" wer:attZ="zzz" attB="bbb" attA="aaa" zxc:attC="ccc" asd:attD="ddd" asd:attE="eee"
qwe:attF="fff"/>
</asd:elementThree>
</qwe:elementTwo>
</elementOne>
}
    doc = Nokogiri::XML::Document.new
    doc << Nokogiri::XML(input, &:noblanks).children
    output = %Q{<ns1:elementOne xmlns:ns1="http://test/1"><ns2:elementTwo xmlns:ns2="http://test/2"><ns3:elementThree xmlns:ns3="http://test/3" xmlns:ns4="http://test/0" xmlns:ns5="http://test/a" ns4:attC="ccc" ns2:attF="fff" ns3:attD="ddd" ns3:attE="eee" ns5:attZ="zzz" attA="aaa" attB="bbb"></ns3:elementThree></ns2:elementTwo></ns1:elementOne>
}
    expect(XMLNormalizer.new(doc).remove_unsed_prefixes.to_s).to eql(output)
  end

end
