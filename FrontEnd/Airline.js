function validation()
{
	var emailfilter=/^\w[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i
	
	var dateVariable = new Date();

//Home Page
	var fDestination = document.form.destination.value;
	
	var fSource = document.form.source.value;
	
	var dmonth = document.form.dmonth.value; //travel month

	var ddate = document.form.ddate.value; //travel date

	var dyear = document.form.dyear.value; //travel year

//Registration Page
	var lName = document.form.lastName.value;

	var fName = document.form.firstName.value;

	var email = emailfilter.test(document.form.email.value);

	var gender = document.form.gender.value;

	var phone = document.form.phone.value;

	var address = document.form.address.value;

	var city = document.form.city.value;

	var state = document.form.state.value;

	var zip = document.form.zip.value;

	var pass = document.form.pass.value; //password


	if(fDestination=="")
		{
		alert("Please enter the name of the city you are traveling to!");	
		document.form.destination.focus();
		return false;
		}

		else if( (fName.length < 2) || (fName.length > 15) )
			{
			alert("Characters of your first name must be between 2 to 15 characters.");
			document.form.destination.focus();
			return false;
			}
			
	if(fSource=="")
		{
		alert("Please enter the name of the city you are traveling to!");	
		document.form.source.focus();
		return false;
		}

		else if( (fName.length < 2) || (fName.length > 15) )
			{
			alert("Characters of your first name must be between 2 to 15 characters.");
			document.form.source.focus();
			return false;
			}
	
	if(dmonth=="")
		{
		alert("Please enter what month you wish to fly on!");	
		document.form.dmonth.focus();
		return false;
		}

		else if(dmonth > "12")
			{
			alert("Please enter a valid month!");
			document.form.dmonth.focus();
			return false;
			}

	if(ddate=="")
		{
		alert("Please enter which date you want to fly on!");	
		document.form.ddate.focus();
		return false;
		}

		else if(ddate > "31")
			{
			alert("Please enter a valid date!");
			document.form.ddate.focus();
			return false;
			}

	if(dyear=="")
		{
		alert("Please enter the year");	
		document.form.dyear.focus();
		return false;
		}

		else if(dyear < "2017")
			{
			alert("You must choose a flight that will take off later than today.");
			document.form.dyear.focus();
			return false;
			}
			
	if(lName=="")
		{
		alert("Please enter your last name!");	
		document.form.lastName.focus();
		return false;
		}

		else if( (lName.length < 2) || (lName.length > 15) )
			{
			alert("Characters of your last name must be between 2 to 15 characters.");
			document.form.lastName.focus();
			return false;
			}
			
	if(fName=="")
		{
		alert("Please enter your frist name!");	
		document.form.firstName.focus();
		return false;
		}

		else if( (fName.length < 2) || (fName.length > 15) )
			{
			alert("Characters of your first name must be between 2 to 15 characters.");
			document.form.firstName.focus();
			return false;
			}
			
	if(email==false)
		{
		alert("Please enter a valid e-mail ID");	
		document.form.email.focus();
		return false;
		}

	if( (form.gender[0].checked==false) && (form.gender[1].checked==false) )
		{
		alert("Please choose your gender!");
		return false;
		}

	if(phone=="")
		{
		alert("Please enter your phone number.");
		document.form.phone.focus();
		return false;
		}

		else if(isNaN(phone))
			{
			alert("Phone number cannot contain characters. Please enter numbers only!");
			document.form.phone.focus();
			return false;
			}

	if(address=="")
		{
		alert("Please enter your home or mailing address.");
		document.form.address.focus();
		return false;
		}

	if(city=="- select -")
		{
		alert("Please enter which city you are from.");
		document.form.city.focus();
		return false;
		}

	if(state=="- select -")
		{
		alert("Please enter which state you are from.");	
		document.form.state.focus();
		return false;
		}

	if(zip=="")
		{
		alert("Please enter your zip code.");
		document.form.zip.focus();
		return false;
		}

		else if(zip.length < 5)
			{
			alert("Please enter a valid zip code!");
			document.form.zip.focus();
			return false;
			}

		else if(isNaN(zip))
			{
			alert("Zip Code in the US cannot contain characters. Please enter numbers only!");
			document.form.zip.focus();
			return false;
			}

	if(pass=="")
		{
		alert("Please enter your password.");
		document.form.pass.focus();
		return false;
		}

		else if( (pass.length < 2) || (pass.length > 5) )
			{
			alert("Your password must consist of 2-5 characters!");
			document.form.pass.focus();
			return false;
			}

			
	else
	{
	alert("Thank you for registering at iFly Bookings "+ fName +" "+ lName +".");
	alert("Your form have been submitted on: " + dateVariable.toString()); 
	}
}