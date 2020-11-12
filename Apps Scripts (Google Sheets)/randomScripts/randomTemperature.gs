  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  var sourceLen = sheetLR - 1;// get the number of patients
  
  
  // Loop through the rows
   for (var i=2;i<sourceLen+2;i++){
     
     var changeValue = Math.random()
     
     if (changeValue <= 0.45){
       var change = -1
     }
     else if(changeValue <= 0.55){
       var change = 0
     }
     else{
       var change = 1
     }

      cell='H'+i
      var actualValue = Number(sheet.getRange(cell).getValue());
      var randomChange = Number((Math.random()*0.25).toFixed(2));
      var newValue = Number(actualValue + (randomChange * change));
      
      sheet.getRange(cell).setValue(newValue);
      
      
  }