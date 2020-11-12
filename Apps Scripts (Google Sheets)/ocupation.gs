// El objetivo de esta función es mandar a la BBDD el número de pacientes que tenemos en camas. Para ello lo que hacemos es mirar cual es la ultima linea escrita en la hoja de calculo de usuarios.
// Si al valor que nos devuelve le restamos 1, sabremos cuantos pacientes tenemos en la UCI, por los que ya podemos mandar la ocupación a la BBDD.
function Ocupation() {
  
  const email = "smarthospital-c09f4@appspot.gserviceaccount.com";
  const key = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCR8B00UdReQNBJ\nBLR4haQ1Zr0VwETSD6V7W8W/KhafnfkKeMNGFwgNo1fBhAixfndDrfrLFDRH2zam\ncibusgvjW0qpQjwZ7ktBL/9xvxbVjunnWBkFb28KuVZQdhYWRlhYYPxXtevzpec5\nxlssXLTaNW79F3kk6RNVHn6rfsCSl5I4Kp6ydlKKpw/FdjkhUxF72E4iWplgLlKu\noyjaI1qYg2swAJfWHk4txU5Bs7Vu0GCfcy/ho97DVY/VobOaIBPYvUfmrZK/RF9Q\n6Cn4fWXmXFX4CUpL0IF6Pcc76X2qZEPlj6M0OC+6+n5W4/mwSbmYi45X8ez1u/9v\n/ODTN6oFAgMBAAECggEAHKaNcTlUbkmeqosmLBgekA5Stlu4Fx5TwFdYx+opJV6D\n5zqkqZS5c8X640a61y/LFcoo96gIiIfgn4Y/HvLs8w535qlWd8fI1ewoo+neP4Bu\nasjopqDFJc+TgrngJbDbRMSLneOdBkkujzDiMuAjcEh3uO/cDHNGpJoXR69bepvD\nx/HLG/+5NU+FJTnyrwxy2AXKuBt09HhrekL3ZjRstCSOZK5Pp7NtRSdV5kVimcjS\nyD4zTTJeVoB6dj24xuolc8VGMG/7G1UqMEd92sijbhwBd8q/rkhYKXoO7Xzia4uV\nGzL5++a4tW8keVuoc/dx/LS/qXyX+HjpgJz6y1ds0QKBgQDBs9ueLaaKWfyy/Wkh\nO5S338ZtyRsLUJH0O/EXXC1bwn1PcvgYMrUIchxI57nJg6GIiPkhoySMruWOVWXP\nx6TPdwI8mR9QVW/jkDy0hh5Zqszs/9J0vWTQql6Hm+oR1dfo5QvRyzcZ1iElATvL\nVYDUnKw1WPNofGa67CbeETv1NQKBgQDA36T2BvnuAPKou8DAEnMTqEOVkVRYmBta\nTQWNkkd+1lEwZEscsfgfpMG1AppQYBbkSIm7zYnhWdO5t9KTHLlJ7LtO/5NuiKUk\nnBm14LXYIeJmIiC/wi6oXULHwSZgXbLHUNZoKZBAmEX5PKnmpK8tscvPt4YlduIT\nCRtHc2aLkQKBgBin4i6SNP6rUaUe6IDYaqe1DjbvQEgCa3GhJ6EHlKZ3bSftxHKg\nEbcPf1YwWM+zt53/gWass3xMzt99M0ZtbScTSO+Ztgitt15J/9Aiuj5DpW4NaiZ9\n7RU6emnciMDYbXExpn1/1nWtce6Z55iMO6fUgX8Q4XrNSu5EHPZrTyx5AoGAErqk\n7i8nPfFhnvj8cqpX+mSwi2mdYy0CGva3v1OhFbQCFkzm7lZp3cjF9qnWClAKaQiS\nN2ZyKSvr33D2RcrYQ1F1ruoqiuVCBBgUdxDnF6HStlBCFdzpYvgLcBJVg64Vmj1D\nVMIUe/FNejJl3TvItws422ba4/Bza53KxFl0b8ECgYA8gMbXIWt9KbB2TwK2fCTQ\nSUcxSystBGWb+JBht+GDucFQVeQCcQqmElRgnp+G59FbGl3usisxlpEw/dL5Tetz\nHRNn/x5YwxfLCkdu2WrObpig+izPga9Ikb8/Dv6/mjOHW12m2kOXVPw47OS9JFFU\ns2P06G2yY6sJ1LIifIS/Zg==\n-----END PRIVATE KEY-----\n";
  const projectId = "smarthospital-c09f4";
  var firestore = FirestoreApp.getFirestore (email, key, projectId);
  
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  

  
  var data = {};
  data.ocupadas = sheetLR-1;
  
  stringAux="camasOcupadas/ocupadas";

  firestore.updateDocument(stringAux,data);

}

