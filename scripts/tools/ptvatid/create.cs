#!/usr/bin/dotnet

// string[] validNifPrefixes = { "1", "2", "3", "5", "6", "8", "45", "70", "71", "72", "74", "75", "77", "79", "90", "91", "98", "99" };
string[] validNifPrefixes = ["90", "91", "98", "99"];
string GenerateUniqueVatId()
{
    var random = new Random(DateTime.Now.Millisecond);
    string generatedNif = string.Empty;
    
    string nifPrefix = validNifPrefixes.ElementAt(random.Next(0, validNifPrefixes.Length)).ToString();

    generatedNif += nifPrefix;

    for (int i = nifPrefix.Length; i <= 7; i++)
    {
        generatedNif += random.Next(0, 10).ToString();
    }

    generatedNif += CalculateCheckDigit(generatedNif).ToString();
    // return "PT"+generatedNif;
    return generatedNif;
}

int CalculateCheckDigit(string value)
{
    int controlSum = 9 * int.Parse(value[..1]) +
                    8 * int.Parse(value.Substring(1, 1)) +
                    7 * int.Parse(value.Substring(2, 1)) +
                    6 * int.Parse(value.Substring(3, 1)) +
                    5 * int.Parse(value.Substring(4, 1)) +
                    4 * int.Parse(value.Substring(5, 1)) +
                    3 * int.Parse(value.Substring(6, 1)) +
                    2 * int.Parse(value.Substring(7, 1));

    int controlMod = controlSum % 11;
    int checkNumber = 11 - controlMod;

    return checkNumber > 9 ? 0 : checkNumber;
}

Console.WriteLine(GenerateUniqueVatId());