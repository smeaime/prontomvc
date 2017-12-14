
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;




// https://stackoverflow.com/questions/38184432/fcm-firebase-cloud-messaging-push-notification-with-asp-net


namespace Sch_WCFApplication
{
    public class PushNotification
    {
        public PushNotification(string deviceId, string mensaje, string titulo)
        {
            try
            {




                // esto tambien hay que modificarlo en el constants.js??

                
                // https://console.firebase.google.com/project/pronto-f87bf/settings/cloudmessaging/ las dos claves estan acá
                var applicationID = "AIzaSyBuC5oWSsrDcmVBa3EIG_-j5le-81mH9E4"; //   este figura como "Clave de servidor hereda..." (quizas era apikey con GCM, pero ahora con FCM no, no?)
                var senderId = "741177410808";  //                                  este figura como "messagingSenderId" en la consola del Firebase. ¡¡¡no es el gcm_sender_id (103953800507)!!!!
                                                //string deviceId = "euxqdp------ioIdL87abVL"; //                   este seria el ticket???  	-It is a token generated using a method FirebaseInstanceId.getInstance().getToken() in a Service – Nilesh Panchal Dec 2 '16 at 12:14 

                //armar el service worker con este ejemplo 
                //https://firebase.google.com/docs/web/setup?hl=es-419  para agregar FCM
                //https://firebase.google.com/docs/cloud-messaging/js/client?hl=es-419  para empezar a usarlo. 
                //https://github.com/firebase/quickstart-js/blob/master/messaging/index.html#L84-L85 ahí está el codigo
                //https://github.com/firebase/quickstart-js/tree/master/messaging todo el codigo
                //por ahora ponelo en Reclamos.aspx. Despues, el registrador tendría que estar llamado en la primera pagina (masterpage o algo)


                // usar firesharp? -es q necesitas una biblioteca para .net?


                // cómo mandar al servidor un mensaje para que el servidor asocie mi ticket de subscripcion con mi nombre de usuario?
                // -lo tenés que hacer vos a mano en el sendTokenToServer del codigo de ejemplo



                WebRequest tRequest = WebRequest.Create("https://fcm.googleapis.com/fcm/send");

                tRequest.Method = "post";

                tRequest.ContentType = "application/json";

                var data = new

                {

                    to = deviceId,

                    notification = new

                    {

                        body = mensaje,

                        title = titulo,

                        icon = "myicon"

                    }
                };

                var serializer = new JavaScriptSerializer();

                var json = serializer.Serialize(data);

                Byte[] byteArray = Encoding.UTF8.GetBytes(json);

                tRequest.Headers.Add(string.Format("Authorization: key={0}", applicationID));

                tRequest.Headers.Add(string.Format("Sender: id={0}", senderId));

                tRequest.ContentLength = byteArray.Length;


                using (Stream dataStream = tRequest.GetRequestStream())
                {

                    dataStream.Write(byteArray, 0, byteArray.Length);


                    using (WebResponse tResponse = tRequest.GetResponse())
                    {

                        using (Stream dataStreamResponse = tResponse.GetResponseStream())
                        {

                            using (StreamReader tReader = new StreamReader(dataStreamResponse))
                            {

                                String sResponseFromServer = tReader.ReadToEnd();

                                string str = sResponseFromServer;

                            }
                        }
                    }
                }
            }

            catch (Exception ex)
            {

                string str = ex.Message;

            }

        }

    }
}
