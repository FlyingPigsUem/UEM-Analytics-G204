//Funcion que randomiza la tension arterial y el pulso del paciente siguiendo los patrones acordados para el proyecto
function myFunction() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last row
  var sourceLen = sheetLR - 1;// get the number of patients
  
  
  // Loop through the rows
   for (var i=2;i<sourceLen+2;i++){
     
     var changeValue = Math.random();
     
     if (changeValue <= 0.4){
       var change = 1;
     }
     else if(changeValue <= 0.65){
       var change = 0;
     }
     else{
       var change = -1;
     }
     
     var extremeChangeValue = Math.random();
     
     if (extremeChangeValue >= 0.95){
       var extremeChange = 10;
     }
     else{
       var extremeChange = 1;
     }

     cellTension = 'I' + i;
     cellPulso = 'J' + i;
     var actualValueTension = Number(sheet.getRange(cellTension).getValue());
     var actualValuePulso = Number(sheet.getRange(cellPulso).getValue());
     var randomChange = Number((Math.random()*3).toFixed(0));
     var newValueTension = Number(actualValueTension + (randomChange * change * extremeChange));
     var newValuePulso = Number(actualValuePulso + (randomChange * change * extremeChange));
     
     sheet.getRange(cellTension).setValue(newValueTension);
     sheet.getRange(cellPulso).setValue(newValuePulso);
  }
}

