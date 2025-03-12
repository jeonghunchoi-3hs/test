$(document).ready(function(){	
   		$('#password-Form').bootstrapValidator({
   	        message: 'This value is not valid',
	        fields: {
	        	loginPassword: {
	                validators: {
	                    notEmpty: {
	                        message: '필수 입력이므로 공백일 수 없습니다.'
	                    },
	                    stringLength: {
	                    	min : 4,
	                    	max : 30,
	                    	message : "4글자 이상, 30글자 이하로 입력하십시오."
	                    }
	                }
	            },
	            confirmLoginPassword : {
	            	validators: {
	            		notEmpty: {
	                        message: '필수 입력이므로 공백일 수 없습니다.'
	                    },
	                    identical: {
	                    	field: 'loginPassword',
	                    	message: '비밀번호가 다릅니다. 다시 확인해 주세요.'
	                    }
	            	}
	            }
	        }
	    })
	    .on('success.form.bv', function(e) {
	        e.preventDefault();
	        var $form = $(e.target);
			$form.attr('action', "passwordUpdate.do");
	        $.post($form.attr('action'), $form.serialize(), function(result) {
	            if(result == 1) { alert("변경되었습니다.") }
	            else { alert("변경이 실패했습니다.") }
	            $('#navModal').modal('hide');		
				location.reload();
	        }, 'json');
	    });
});