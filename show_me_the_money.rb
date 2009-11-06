# pretvara 2 iznosa (kune i lipe) u iznos riječima
# Autor: Tomislav Car, Matej Špoler, Josip Bišćan
# Infinum d.o.o., 2009

class ShowMeTheMoney
  JEDINICE = [
    'nula', 'jedna', 'dvije', 'tri', 'četiri', 'pet',
		'šest', 'sedam', 'osam', 'devet', 'deset',
		'jedanaest', 'dvanaest', 'trinaest' , 'četrnaest',
		'petnaest', 'šesnaest', 'sedamnaest', 'osamnaest', 'devetnaest'
  ]

  JEDINICE_MUSKE = JEDINICE.map{|x| # za miliune
    case x
      when 'jedna'
        'jedan'
      when 'dvije'
        'dva'
      else
        x
    end
  }

  DESETICE = ['', '', 'dvadeset', 'trideset', 'četrdeset', 'pedeset',
									   'šezdeset', 'sedamdeset', 'osamdeset', 'devedeset']

  STOTICE = ['', 'sto', 'dvjesto', 'tristo', 'četristo', 'petsto',
											   'šesto', 'sedamsto', 'osamsto', 'devetsto']

  RIJECI = {
    :milijun => {
      :one => 'milijun',
      :many => 'milijuna'
    },
    :tisucu => {
      :one => 'tisuću',
      :few => 'tisuće',
      :many => 'tisuća'
    },
    :kuna => {
      :one => 'kuna',
      :few => 'kune', # nije skroz tocno zbog 22 kune, 23 kune ali ovdje prolazi
      :many => 'kuna'
    },
    :lipa => {
      :one => 'lipa',
      :few => 'lipe',
      :many => 'lipa'
    }
  }

  VEZNIK = 'i'
  SEPARATOR = ' ' # FIXME ne radi ako je ovo prazan string

  # slaze cijenu slovima iz broja
  def kune_in_words(kune, lipe)
    parts = []
    parts << number_to_string(kune.to_s).join(SEPARATOR).strip
    parts << RIJECI[:kuna][quantify_amount(kune)]

    # dodaj veznik
	  parts << VEZNIK if kune > 0

    parts << number_to_string(lipe.to_s).join(SEPARATOR).strip
    parts << RIJECI[:lipa][quantify_amount(lipe)]

    # u nekim okolnostima moze doci do dvostrukog separatora pa da to maknem
	  parts.join(SEPARATOR).gsub(SEPARATOR*2, ' ')
  end

  def quantify_amount(amount)
    (2..4).include?(amount % 10) && !(12..14).include?(amount % 100) ? :few : :many
  end

  # slaze od broja njegov tekstualni oblik
  # rekurzivno se poziva za tisucice i miliune
  def number_to_string(number, thousands = false, millions = false)
    # brojevi do 20 su specificni
	  return [JEDINICE[0]] if number=='0' || number=='00'

	  num = number.split("").reverse

	  parts = []

	  if !thousands
		  num_miliun = num[8].to_s + num[7].to_s + num[6].to_s

		  if num_miliun!=""
		    quantifier = num_miliun=="1" ? :one : :many
			  parts += number_to_string(num_miliun, true, true) if num_miliun!=1
        parts << RIJECI[:milijun][quantifier]
		  end

		  num_tisucu = num[5].to_s + num[4].to_s + num[3].to_s
		  if (num_tisucu.to_i > 0)
        parts += number_to_string(num_tisucu, true) if (num_tisucu.to_i != 1)

			  if (num_tisucu.to_i == 1)
          quantifier = :one
  		  else
  			  if (num[3].to_i == 1)
            quantifier = :many
  			  elsif (num[3].to_i < 5)
            quantifier = :few
	  		  else
            quantifier = :many
   			  end
  		  end

				parts << RIJECI[:tisucu][quantifier]
		  end
	  end

	  parts << STOTICE[num[2].to_i] if num[2] # stotice
	  parts << DESETICE[num[1].to_i] if num[1] # desetice

    array = millions ? JEDINICE_MUSKE : JEDINICE
	  if num[1].to_i==1 # brojevi od 10 do 20 (stotice ne racunamo)
		  parts << array[(num[1] + num[0]).to_i]
	  elsif num[0] # jedinice, s time da su desetice ili 0 ili vece od 1
		  parts << array[num[0].to_i]
	  end

	  parts
  end
end

