//Funcion que randomiza la capnografía del paciente siguiendo los patrones acordados para el proyecto
function randomCapnografía() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  var sourceLen = sheetLR - 1;// get the number of patients
  
  
  // Loop through the rows
   for (var i=2;i<sourceLen+2;i++){
     
     var changeValue = Math.random()
     
     if (changeValue <= 0.3){
       var change = -1
     }
     else if(changeValue <= 0.7){
       var change = 0
     }
     else{
       var change = 1
     }

      cell='S'+i
      var actualValue = Number(sheet.getRange(cell).getValue());
      var randomChange = Number((Math.random()*3).toFixed(2));
      var newValue = Number(actualValue + (randomChange * change));
      
      sheet.getRange(cell).setValue(newValue);
      
      
  }
}
