//EL objetivo de esta función es darle valores pseudoaleatorios a los pacientes que se dan de alta mediante la aplicación. Una vez se añade un nuevo paciente mediante la aplicación, los valores que sean null se actualizarán con los valores 
// previamente establecidos. Se accede a la última fila del documento, en el cual se habrá añadido el usuario y se cambian los datos faltantes mediante un random.
function nuevoUsuario() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheetname = "Usuarios";
  
  var sheet = ss.getSheetByName(sheetname); 
  // get the last row and column in order to define range
  var sheetLR = sheet.getLastRow(); // get the last rowç
  
  
  Logger.log(sheetLR);
  if(SpreadsheetApp.getActiveSheet().getRange('I'+sheetLR).getValue()=='NULL'){
  SpreadsheetApp.getActiveSheet().getRange('I'+sheetLR).setValue((Math.random()*40+60).toFixed(0));
  SpreadsheetApp.getActiveSheet().getRange('J'+sheetLR).setValue((Math.random()*80+40).toFixed(0));
  SpreadsheetApp.getActiveSheet().getRange('K'+sheetLR).setValue((Math.random()*25+5).toFixed(0));
  SpreadsheetApp.getActiveSheet().getRange('L'+sheetLR).setValue((Math.random()*5).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('M'+sheetLR).setValue((Math.random()*6+6).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('N'+sheetLR).setValue((Math.random()*20+10).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('O'+sheetLR).setValue((Math.random()*20+30).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('P'+sheetLR).setValue((Math.random()*15+85).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('Q'+sheetLR).setValue((Math.random()*13+10).toFixed(1));
  SpreadsheetApp.getActiveSheet().getRange('R'+sheetLR).setValue((Math.random()*120+40).toFixed(0));
  SpreadsheetApp.getActiveSheet().getRange('S'+sheetLR).setValue((Math.random()*20+30).toFixed(1));
  }
}

