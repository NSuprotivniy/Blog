// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require turbolinks
//= require_tree .



////////////////////////////////////////////////////////////////
// File upload 
////////////////////////////////////////////////////////////////

function readURL(input) {
    if (input.files) {
    
    		
        var $container = $('#img_thumbnails');    

        $('.new_image').remove();
        
    		for (var i = 0; i < input.files.length; i++) {

        	var reader = new FileReader();
          
        	reader.onload = function (e) {
        		$container.append(
        			'<div class="col-xs-4 thumbnail new_image">' +
        				'<img src="'+ e.target.result + '" class="img-responsive" />' +
        			'</div>'
        		);
        	}
        
          reader.readAsDataURL(input.files[i]);
        }
    }
}

function ready(){	

	$("#imgInp").change(function(){
	    readURL(this);
	});
}

///////////////////////////////////////////////////////////////

$(document).on('turbolinks:load', ready);