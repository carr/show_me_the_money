class ShowMeTheMoney
  JEDINICE = ['nula', 'jedna', 'dvije', 'tri', 'četiri', 'pet',
										   'šest', 'sedam', 'osam', 'devet', 'deset',
										   'jedanaest', 'dvanaest', 'trinaest' , 'četrnaest',
										   'petnaest', 'šesnaest', 'sedamnaest', 'osamnaest', 'devetnaest']

  tmp = JEDINICE
  tmp[1] = 'jedan'
  tmp[2] = 'dva'

  JEDINICE_MUSKE = tmp # za miliune

  DESETICE = ['', '', 'dvadeset', 'trideset', 'četrdeset', 'pedeset',
									   'šezdeset', 'sedamdeset', 'osamdeset', 'devedeset']

  STOTICE = ['', 'sto', 'dvjesto', 'tristo', 'četristo', 'petsto',
											   'šesto', 'sedamsto', 'osamsto', 'devetsto']
  POM_RIJECI = {
    'miliun'=>'miliun',
    'miliuna'=>'miliuna',
		'tisucu'=>'tisuću',
		'tisuce'=>'tisuće',
		'tisuca'=>'tisuća',
		'kuna'=>'kuna',
		'kune'=>'kune',
	  'lipa'=>'lipa',
	  'lipe'=>'lipe',
		'veznik'=>' i '
  }

  # slaze cijenu slovima iz broja
  def number_to_string($number)
	  $num_1 = substr($number, 0, -3)
	  $num_2 = substr($number, -2)

    # ocistimo separatore u kunskom dijelu
	  $num_1 = $num_1.gsub(".", '') # da nam ne razjebavaju sustav
	  $num_1 = $num_1.gsub(",", '')

	  $num_1_str = number_to_string_rek($num_1, 0).strip # kn
	  $num_2_str = number_to_string_rek($num_2, 0) # lp


	  $ret = $num_1_str + ' '
	  $num_1 = array_reverse(str_split($num_1))
	  $num_1_pom = $num_1[1] . $num_1[0]
	  $num_2 = array_reverse(str_split($num_2))
	  $num_2_pom = $num_2[1] . $num_2[0]

	  # kune
	  if ($num_1[0]!=2 && $num_1[0]!=3 && $num_1[0]!=4 ) # brojevi koji zavrsavaju na 2,3,4 imaju 'kune', ostali 'kuna'
		  $ret .=  POM_RIJECI['kuna']
	  else
		  $ret .=  POM_RIJECI['kune']
    end

    # dodaj veznik
	  if ($ret!='')
		  $ret .= POM_RIJECI['veznik']
    end

	  # lipe
	  if (($num_2[0]==2 || $num_2[0]==3 || $num_2[0]==4) && !($num_2_pom>11 && $num_2_pom<14)) # 2,3,4 lipe, ostalo lipa
		  $ret .= $num_2_str . ' ' . POM_RIJECI['lipe']
	  else
		  $ret .= $num_2_str . ' ' . POM_RIJECI['lipa']
    end

	  return $ret
  end

  # slaze od broja njegov tekstualni oblik
  # rekurzivno se poziva za tisucice i miliune
  def number_to_string_rek($number, $rek, $miliuni=0)
	  $str = ''

	  $num = str_split($number)
	  $num = array_reverse($num);

	  if ($number=='0' || $number=='00') #brojevi do 20 su specificni
		  return JEDINICE[0]


	  if (!$rek)
		  $num_tisucu = $num[5] . $num[4] . $num[3]
		  $num_miliun = $num[8] . $num[7] . $num[6]

		  if ($num_miliun>0)
			  if ($num_miliun==1)
				  $str .= ' ' . POM_RIJECI['miliun'] . ' ';
			  elsif ($num[6]==1)
				  $str .= number_to_string_rek($num_miliun, 1, 1) . ' ' . POM_RIJECI['miliun'] . ' '
			  else
				  $str .= number_to_string_rek($num_miliun, 1, 1). ' ' . POM_RIJECI['miliuna'] . ' '
  		  end
		  end

		  if ($num_tisucu>0)
			  if ($num_tisucu==1)
				  $str .= ' ' . POM_RIJECI['tisucu'] . ' '
			  elsif ($num[3]==1)
				  $str .= number_to_string_rek($num_tisucu, 1) . ' ' . POM_RIJECI['tisuca'] . ' '
			  elsif ($num[3]<5)
				  $str .= number_to_string_rek($num_tisucu, 1) . ' ' . POM_RIJECI['tisuce'] . ' '
			  else
				  $str .= number_to_string_rek($num_tisucu, 1). ' ' . POM_RIJECI['tisuca'] . ' '
  		  end
		  end
	  end

	  if ($num[2]) # stotice
		  $str .= STOTICE[$num[2]] . ' '
	  if ($num[1]) # desetice
		  $str .= DESETICE[$num[1]] . ' '
	  if ($num[1]==1) # brojevi od 10 do 20 (stotice ne racunamo)
		  if ($miliuni)
			  $str .= JEDINICE_MUSKE[$num[1] . $num[0]]
		  else
			  $str .= JEDINICE[$num[1] . $num[0]]
	    end
	  elsif ($num[0]) # jedinice, s time da su desetice ili 0 ili vece od 1
		  if ($miliuni)
			  $str .= JEDINICE_MUSKE[$num[0]]
		  else
			  $str .= JEDINICE[$num[0]]
  	  end
	  end

    # u nekim okolnostima moze doci do dvostrukog razmaka pa da to maknem
	  $str = $str.gsub('  ', ' ')

	  return $str
  end
end

