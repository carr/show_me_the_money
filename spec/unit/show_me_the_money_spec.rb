require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe ShowMeTheMoney do

    {
      "0.11" => "nula kuna jedanaest lipa",
      "1.44" => "jedna kuna i četrdeset četiri lipe",
      "123.22" => "sto dvadeset tri kune i dvadeset dvije lipe",
      "213.12" => "dvjesto trinaest kuna i dvanaest lipa",
      "1234.56" => "tisuću dvjesto trideset četiri kune i pedeset šest lipa",
      "2209.12" => "dvije tisuće dvjesto devet kuna i dvanaest lipa",
      "3323.00" => "tri tisuće tristo dvadeset tri kune i nula lipa",
      "45353.33" => "četrdeset pet tisuća tristo pedeset tri kune i trideset tri lipe",
      "90300.00" => "devedeset tisuća tristo kuna i nula lipa",
      "232445.88" => "dvjesto trideset dvije tisuće četristo četrdeset pet kuna i osamdeset osam lipa",
      "566321.00" => "petsto šezdeset šest tisuća tristo dvadeset jedna kuna i nula lipa",
      "1134299.17" => "jedan milijun sto trideset četiri tisuće dvjesto devedeset devet kuna i sedamnaest lipa",
      "2998877.11" => "dva milijuna devetsto devedeset osam tisuća osamsto sedamdeset sedam kuna i jedanaest lipa",
      "2998877.12" => "dva milijuna devetsto devedeset osam tisuća osamsto sedamdeset sedam kuna i dvanaest lipa",
      "12998877.12" => "dvanaest milijuna devetsto devedeset osam tisuća osamsto sedamdeset sedam kuna i dvanaest lipa",
      "343526879.02" => "tristo četrdeset tri milijuna petsto dvadeset šest tisuća osamsto sedamdeset devet kuna i dvije lipe"
    }.each_pair do |amount, words|
      it "should return correct for #{amount}" do
          arr = amount.split(".")
          kune, lipe = arr[0].to_i, arr[1].to_i

          ShowMeTheMoney.new.kune_in_words(kune, lipe).should == words
      end
    end
end

