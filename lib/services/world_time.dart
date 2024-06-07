
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;//location name for the ui
  String? time; //the time in the location
  String? flag; // url to an asset flag icon
  String? url;  //location url for api end point
  bool? isDaytime; // true or false if daytime or not

  WorldTime({required this.location,required this.flag, required this.url});


  Future<void> getTime() async {

    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offsetHours = data['utc_offset'].substring(0,3);
     // print(data['utc_offset']);
      String offsetMinutes = data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime); //parse converts into object
      now =  now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));



      //set time to property
      isDaytime = now.hour > 6 && now.hour < 19 ? true:false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('caught error:$e');
      time = 'could not get time';
    }

  }

}


