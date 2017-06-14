quote = "I changed my password to incorrect. So that when I forget it, it always shows my the correct password"
io.write("Size is : ", #quote, "\n")

io.write("Replace I with Me : ", string.gsub(quote, "I", "Me"), "\n")

io.write("Index of poasswrd : ", string.find(quote, "password"), "\n")