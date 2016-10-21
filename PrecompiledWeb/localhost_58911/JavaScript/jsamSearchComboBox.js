// jsamSearchComboBox

//Public var
var totalchar = 3;

//Private var

function SearchComboBox(el,funtionName)
{
    if (el != null)
    {    
        if (el.value.length >= totalchar)
            ExecuteCall(document.referrer,el,funtionName);
    }
}

