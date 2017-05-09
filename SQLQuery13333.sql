
presupuestosobras_

  select * from wTempCartasPorteFacturacionAutomatica

  --sp_helptext   PresupuestoObrasNodos_tx_ParaArbol
  PresupuestoObrasNodos_tx_ParaArbol   '77' -- -1

  --sp_helptext 
  PresupuestoObrasNodos_Inicializar


  --sp_helptext PresupuestoObrasNodos_tx_PorNodo 

  PresupuestoObrasNodos_tx_PorNodo 39255 

  obras_tx_activas 'SI','SI'
   Aplicacion.Obras.TraerFiltrado("_Activas", Array("SI", "SI", glbIdUsuario))