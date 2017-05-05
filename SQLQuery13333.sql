
presupuestosobras_

  select * from wTempCartasPorteFacturacionAutomatica

  --sp_helptext   PresupuestoObrasNodos_tx_ParaArbol
  PresupuestoObrasNodos_tx_ParaArbol   '01' -- -1

  --sp_helptext 
  PresupuestoObrasNodos_Inicializar


  --sp_helptext PresupuestoObrasNodos_tx_PorNodo 

  PresupuestoObrasNodos_tx_PorNodo 0 -1

  obras_tx_activas 'SI','SI'
   Aplicacion.Obras.TraerFiltrado("_Activas", Array("SI", "SI", glbIdUsuario))