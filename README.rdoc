= SBIF

* https://github.com/pbruna/sbif_wrapper

== DESCRIPTION:

A Ruby library for working with the SBIF API (Superintendencia de Bancos e Instituciones Financieras de Chile).
You can find more information of the SBIF API here: http://api.sbif.cl/documentacion/


== SYNOPSIS:
At the moment you can query for the following currencys:

* Dolar
* Euro
* UF
* UTM

For each of this you can get the value for:

* a specific date,
* a month in a given year,
* a year

Befor you can start using this wrapper you need to get an API Key. You can ask for one here: http://api.sbif.cl/uso-de-api-key.html

   require 'sbif'
   sbif = SBIF.new(:api_key => "fff9cd0d852f6bb3330fc7c55978761603cbcb10")
   
   uf = sbif.euro(:year => 2011, :month => 9) # Hash => Date:Value

   dolar = sbif.dolar # Value for today

   utm = sbif.utm(:month => 9) # As we can not known for which year, we return the value for today
  
That is for now

== REQUIREMENTS:

* JSON
* OpenURI

== INSTALL:

* gem install sbif


== LICENSE:

(The MIT License)

Copyright (c) 2011 Patricio Bruna

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
