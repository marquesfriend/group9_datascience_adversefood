#making a new column for age in years and naming it
adversefood$newcolumn <- NA
names(adversefood)[names(adversefood) == 'newcolumn'] <- 'CI.Age.at.Adverse.Event.in.Years'

#writing a loop to convert all ages to years, to identify nonsensical outliers
for (i in 1:90786) {
  if (adversefood[i, 9] == "Decade(s)")
    adversefood[i, 13] = adversefood[i, 8]*10
  else if (adversefood[i, 9] == "Year(s)")
    adversefood[i, 13] = adversefood[i, 8]
  else if (adversefood[i, 9] == "Month(s)")
    adversefood[i, 13] = adversefood[i, 8]/12
  else if (adversefood[i, 9] == "Day(s)")
    adversefood[i, 13] = adversefood[i, 8]/365
}