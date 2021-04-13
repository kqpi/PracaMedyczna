--Script made by kqpi
Config = {}
Config.CzasOperacji = 20000 -- Zwykly czas Operacji, 10000 - 10 sekund
Config.CzasOperacjiPielegniarka = 15000 -- Czas Operacji z pomocą pielęgniarki, 10000 - 10 sekund
Config.CzasWypelniania = 30000 -- Czas wypełniania papierków
Config.NazwaPracy = "ambulance" -- Nazwa skryptowa pracy
Config.NazwaFrakcji = "EMS" -- Nazwa Frakcji
Config.IleSiana = math.random(1000,1200) -- Ile $ otrzymujemy za wykonaną prace
Config.IleSianaPielegniarka = math.random(800,1000) -- Ile $ otrzymujemy za wykonaną prace z pomocą pielęgniarki

Config.StartPracy = {
	{x = 310.83, y = -599.39, z = 43.29}, --Tu wpisujecie koordy gdzie ma się zaczynać pracę
}

Config.SalaOperacyjna = {
	{x = 323.19, y = -581.65, z = 43.32}, --Tu wpisujecie koordy sali operacyjnej
}

Config.AnulowaniePracy = {
	{x = 323.34, y = -575.0, z = 43.32}, --Tu wpisujecie koordy gdzie można anulować prace
}

Config.StartOperacji = {
	{x = 319.86, y = -578.71, z = 43.32}, --Tu wpisujecie koordy gdzie zaczyna się główna operacja
}

Config.MiejscePapierka = {
	{x = 316.13, y = -583.42, z = 43.32}, --Tu wpisujecie koordy gdzie ma być praca papierkowa
}