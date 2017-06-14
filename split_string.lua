function splitStr(theString)
	stringTable = {} -- acts as an array where we are going add words

	local i = 1

	for str in string.gmatch(theString, "[^%s]+") do

		stringTable[i] = str
		i = i + 1

	end
	return stringTable, i
end

splitStrTable, numOfStr = splitStr("The Turtle")

for j = 1, numOfStr-1 do
	print(string.format("%d : %s", j, splitStrTable[j]))

end
