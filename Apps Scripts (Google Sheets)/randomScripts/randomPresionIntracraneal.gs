//Funcion que randomiza la presion intracraneal del paciente siguiendo los patrones acordados para el proyecto
function randomPresionIntracraneal() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  var sourceLen = sheetLR - 1;// get the number of patients
  
  
  // Loop through the rows
   for (var i=2;i<sourceLen+2;i++){
     
     var changeValue = Math.random()
     
     if (changeValue <= 0.2){
       var change = -1
     }
     else if(changeValue <= 0.9){
       var change = 0
     }
     else{
       var change = 1
     }

      cell='Q'+i
      var actualValue = Number(sheet.getRange(cell).getValue());
      var randomChange = Number((Math.random()*3).toFixed(1));
      var newValue = Number(actualValue + (randomChange * change));
      
      sheet.getRange(cell).setValue(newValue);
      
      
  }
}
