	var ie5 = (document.getElementById && document.all); 
	var ns6 = (document.getElementById && !document.all);
    var custWindowOpen = false;
    var ListWindowOpen = false;
    var xMouse = 0;
    var yMouse = 0;
	var deltaX = 5;
	var deltaY = 10;
	
	
 
    function closePed()
    {
        var el = document.getElementById("PedidoData");
        VisibilityChange(el,false,false);
        var pb = document.getElementById('bkgDark');
        pb.style.display = "none";
        pb.style.visibility = "hidden";
    }
    
    function closeReq()
    {
        var el = document.getElementById(elReq);
        VisibilityChange(el,false,false);
        var pb = document.getElementById('bkgDark');
        pb.style.display = "none";
        pb.style.visibility = "hidden";
    }
    
    function VisibilityChange(el,show,preserveCoord)
    {
        var visible;
        var display;
        if (show)
        {
            visible = "visible";
            display = "block";
            if (! preserveCoord)
            {
                el.style.left= xMouse;
                el.style.top= yMouse;
            }
        }
        else
        {              
            visible = "hidden";
            display = "none";            
        }
        el.style.visibility = visible;
        el.style.display = display;
    }
    
    function getMouseMove(e){
		var posX;
		var posY;
		if (window.innerHeight)
    {
		      posX = window.pageXOffset;
		      posY = window.pageYOffset;
	    }
	    else if (document.documentElement && document.documentElement.scrollTop)
	    {
		    posX = document.documentElement.scrollLeft;
		    posY = document.documentElement.scrollTop;
	    }
	    else if (document.body)
	    {
		      posX = document.body.scrollLeft;
		      posY = document.body.scrollTop;
	    }

		if(ie5){
			xMouse = posX + event.clientX;
			yMouse = posY + event.clientY+ deltaY ;
		}
		else if(ns6){
			xMouse = posX + e.clientX;
			yMouse = posY + e.clientY+ deltaY + "px";
		}
	}
    
     
    
    //AJAX
    
    function GetXmlHttpObject(handler)
    { 
        var objXmlHttp = null;
        
        if (!window.XMLHttpRequest)
        {
            // Microsoft
            objXmlHttp = GetMSXmlHttp();
            if (objXmlHttp != null)
            {
                objXmlHttp.onreadystatechange = handler;
            }
        } 
        else
        {
            // Mozilla | Netscape | Safari
            objXmlHttp = new XMLHttpRequest();       
            if (objXmlHttp != null)
            {
                objXmlHttp.onload = handler;
                objXmlHttp.onerror = handler;
                objXmlHttp.onreadystatechange = handler;
            } 
        } 
        return objXmlHttp; 	    
     } 

    function GetMSXmlHttp()
    {
        var xmlHttp = null;
        var clsids = ["Msxml2.XMLHTTP.6.0",
                     "Msxml2.XMLHTTP.4.0","Msxml2.XMLHTTP.3.0", 
                     "Msxml2.XMLHTTP.2.6","Microsoft.XMLHTTP.1.0", 
                     "Microsoft.XMLHTTP.1"];
        for(var i=0; i<clsids.length && xmlHttp == null; i++) {
            xmlHttp = CreateXmlHttp(clsids[i]);
        }
        return xmlHttp;
    }

    function CreateXmlHttp(clsid) {
        var xmlHttp = null;
        try {
            xmlHttp = new ActiveXObject(clsid);
            lastclsid = clsid;
            return xmlHttp;
        }
        catch(e) {}
    }


    function SendXmlHttpRequest(xmlhttp, url) 
    { 
        xmlhttp.open('GET', url, true); 
        xmlhttp.send(null); 
    }
    
    var xmlHttp = null; 
    var panelType = null;
    
    function ExecuteCall(url,pt)
    { 
        try 
        { 
            ShowElementWaiting();
            	    
            if (pt == elReq)
        	    xmlHttp = GetXmlHttpObject(CallbackMethodReq); 
        	else 
           	    xmlHttp = GetXmlHttpObject(CallbackMethodPed); 
        	    
            SendXmlHttpRequest(xmlHttp, url); 
        }
        catch(e){} 
    }
    
   
    //CallbackMethod will fire when the state 
    //has changed, i.e. data is received back 
    
    
    function CallbackMethodReq() 
    { 
        try
        {
            //readyState of 4 or 'complete' represents 
            //that data has been returned 
            if (xmlHttp.readyState == 4 || 
                xmlHttp.readyState == 'complete')
            {  
                VisibilityChange(document.getElementById(elPrg),false,true);
                var response = xmlHttp.responseText; 
                if (response.length > 0)
                   ShowElementHtml(document.getElementById(elReq),response); 
            }
        }
        catch(e){}
    }
    
    
    function CallbackMethodPed() 
    { 
        try
        {
            //readyState of 4 or 'complete' represents 
            //that data has been returned 
            if (xmlHttp.readyState == 4 || 
                xmlHttp.readyState == 'complete')
            {  
               
                VisibilityChange(document.getElementById(elPrg),false,true);
                var response = xmlHttp.responseText; 
                if (response.length > 0)
                {
                    //update page
                    
                   ShowElementHtml(document.getElementById(elPed),response); 
                   
                } 
            }
        }
        catch(e){}
    }
   
    function ShowElementWaiting()
    {
	    var el = document.getElementById(elPrg);
	    if (el != null)
        {
            var bkg = document.getElementById("bkgDark");
            setBkgSize(bkg);
            VisibilityChange(bkg,true,false);
	        ShowElementHtml(el,'<img src="../Imagenes/spinner.gif" width="220px" height="19px"><br><b><span style="color: white">Cargando...</span></b>');
	    }
	    
    }
    

    function ShowElementHtml(el,response,val)
    {
	    if (el != null)
	    {
	        var pos = getScroll();
            el.style.top =  Math.max(15,pos.y+ parseInt(screen.availHeight / 2 - getValue(el.style.height) / 2)) + "px";
            //el.style.left = Math.max(15, pos.x + parseInt(screen.availWidth / 2 - getValue(el.style.width) / 2)) + "px";
            //Modificacion Mariano
            el.style.left = (Math.max(15, pos.x + parseInt(screen.availWidth / 2 - getValue(el.style.width) / 2)) -300)+ "px"; 
            
	        if (ie5){
	            
	            if ((el.id == elReq)||(el.id == elPed))
	            el.innerHTML = quitaForm(response);
	            else
	            el.innerHTML = response;
	            }
	        else    
	            el.innerHTML = response;
	        VisibilityChange(el,true,true);
	        
	    }  
    }
      
    function quitaForm(response)
    {
        var re = /<\/?form[^>]*>/g;
        return response.replace(re,"");
    }
      
    function ShowRequerimiento(id,empresa,pt)
    {
	    ExecuteCall("DocumentosAFirmar.aspx?cmd=showReq&id="+id+"&empresaName="+empresa,pt);
    }
    
    function ShowPedido(id,empresa,pt)
    {
	    ExecuteCall("DocumentosAFirmar.aspx?cmd=showPed&id="+id+"&empresaName="+empresa,pt);
    } 
    
    function closeShowData()
    {
        VisibilityChange(document.getElementById(elPrg),false,true);
    }     
    
    function setBkgSize(bkg)
    {
        if (ns6)
        {
            bkg.style.width = document.width + "px";
            bkg.style.height = document.height + "px";
        }
        else
        {
            var pos = getScroll();
            bkg.style.width = screen.width + pos.x + "px";
            bkg.style.height = screen.height + pos.y +"px";
        }
    }
	
	function getScroll()
	{
		var pos =  new Object();
	    if (window.innerHeight)
	        {
	              
		          pos.x = window.pageXOffset;
		          pos.y = window.pageYOffset;
	        }
	        else if (document.documentElement && document.documentElement.scrollTop)
	        {
		        pos.x = document.documentElement.scrollLeft;
		        pos.y = document.documentElement.scrollTop;
	        }
	        else if (document.body)
	        {
		          pos.x = document.body.scrollLeft;
		          pos.y = document.body.scrollTop;
	        }
	        
	        return pos;
	}
	
	function getValue(value)
	{
	    return value.substr(0,value.length - 2);
	}
   
        
	
