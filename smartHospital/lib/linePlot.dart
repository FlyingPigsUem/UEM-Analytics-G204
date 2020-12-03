import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class LinePLot extends StatelessWidget {
  LinePLot({
    @required this.data,
  });

  final List<double> data;
 
  @override
  Widget build(BuildContext context) {
    List<PlotData> dataSource=[];
    for (int i =0;i<data.length;i+=1){
      dataSource.add(PlotData(i.toString(),data[i]));
    }



    
     return Container(
            child: Center(
                child: Container(
                    //Initialize chart
                    child: SfCartesianChart(
                      
                       tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: CategoryAxis(),
                      series:<ChartSeries>[
                        LineSeries<PlotData,String>(
                          dataSource:dataSource,
                          xValueMapper: (PlotData y, _) => y.x,
                          yValueMapper: (PlotData y, _) => y.y,
                          
                        )
                      ]
                    )
                )
            )
        );
    }
}

class PlotData{
  String x;
  double y;

  PlotData(this.x,this.y);
}