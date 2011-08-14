// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function(){
      $('#user_graph').ready(function(){
       	   var history_array = $('#histories_array').val();
       	  
       	   if(history_array){	
       	     history_array = history_array.split(" ");
       	   } else {    
       	     history_array = [];
       	   }
       	   
       	   user_graph(history_array);
       });
      
      $('#question_input').keyup(function(){
      	if($(this).val().length > 140){		      
      	  text = $(this).val().substring(0, 140);
          $(this).val(text);
          alert("Questions can only be 140 characters for now. sorry");
        }
      });
      
      $('#answer_input').keyup(function(){
      	if($(this).val().length > 100){		      
      	  text = $(this).val().substring(0, 100);
          $(this).val(text);
          alert("Answers can only be 100 characters for now. sorry");
        }
      });
});

function user_graph(graph_array){
	
	var title = $('#question_name').val();
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Answer');
        data.addColumn('number', 'Count');
        
        if(graph_array.length > 0){
          data.addRows(graph_array.length);
        } else {
          data.addRows(1);
        }
        
        for(i=0; i < graph_array.length; i++){
         var myString = graph_array[i].split(",");
         data.setValue(i, 0, myString[0].replace(/&&&/g, " "));
         data.setValue(i, 1, parseInt(myString[1]));
        }

        // Set chart options
      var options = {'title':title,
                     'width':400,
                     'height':300};

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.PieChart(document.getElementById('user_graph'));
      chart.draw(data, options);
        
}
