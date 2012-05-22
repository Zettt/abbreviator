# Abbreviator version 1 written by Zettt at 2009-08-16

# read from file named abbreviations.csv and read each line into a string object
inputAbbrevs = ""
if File.exists?("abbreviations.csv")
    csvfile = File.open("abbreviations.csv")
    csvfile.each { |line| inputAbbrevs.concat line }    
else
    puts "No file \"abbreviations.csv\" found."
    puts "File has to have EXACTLY that name."
    puts "Exiting now."
    exit
end

# these strings contain the header informations surrounding the inner dictionaries, keys, values and everything
header = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
"

theStart = "<dict>
\t<key>groupInfo</key>
\t<dict>
\t\t<key>expandAfterMode</key>
\t\t<integer>0</integer>
\t\t<key>groupName</key>
\t\t<string>CSV Abbreviations</string>
\t</dict>
\t<key>snippetsTE2</key>
\t<array>
"

theEnd = "\t\t</array>
\t</dict>
</plist>"


# encode entities
# i don't know if any other entities need to be encoded. 
# only had issues with ampersand.
if inputAbbrevs.match('&') != nil
    inputAbbrevs.gsub!(/&/, "&amp;")
end

# this splits the abbreviations into an array

abbrevsArray = inputAbbrevs.split(/\n/).map { |line| line.delete("\"").split(/;|,/)}

# the "inner" dictionary
i = 0
outputAbbrevs = ""
while i < abbrevsArray.length
    outputAbbrevs.concat "\t\t<dict>\n"
    outputAbbrevs.concat "\t\t\t<key>abbreviation</key>\n"
    outputAbbrevs.concat "\t\t\t<string>" + abbrevsArray[i][0] + "</string>\n"
    outputAbbrevs.concat "\t\t\t<key>abbreviationMode</key>\n"
    outputAbbrevs.concat "\t\t\t<integer>2</integer>\n"
    outputAbbrevs.concat "\t\t\t<key>flags</key>\n"
    outputAbbrevs.concat "\t\t\t<integer>0</integer>\n"
    outputAbbrevs.concat "\t\t\t<key>plainText</key>\n"
    outputAbbrevs.concat "\t\t\t<string>" + abbrevsArray[i][1] + "</string>\n"
    outputAbbrevs.concat "\t\t\t<key>snippetType</key>\n"
    outputAbbrevs.concat "\t\t\t<integer>0</integer>\n"
    outputAbbrevs.concat "\t\t</dict>\n"
    i += 1
end

# puts outputAbbrevs

# create a new file, write and then close it
outputFile = File.new("abbreviations.textexpander", "w+")

outputFile.puts header
outputFile.puts theStart
outputFile.puts outputAbbrevs
outputFile.puts theEnd

outputFile.close

puts "Seems like everything went fine."
puts "Have fun with your newly created Snippets."