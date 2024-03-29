;DEFTEMPLATE
(deftemplate nodo
	(slot nombre)
	(slot tipo)
	(slot pregunta)
	(slot nodo-si)
	(slot nodo-no)
	(slot respuesta)
)

(deftemplate nodo-pregunta-respuesta
  (slot tipo)
  (slot valor)
)


;DEFFACTS
(deffacts hechos-iniciales
(nodo (nombre nodo-0) (tipo decision) (pregunta "�Dicha situacion ocurre muy a menudo (si/no)?: ") (nodo-si nodo-1) (nodo-no nodo-2))
(nodo (nombre nodo-1) (tipo respuesta) (respuesta "El nivel de probabilidad es FRECUENTE"))
(nodo (nombre nodo-2) (tipo decision) (pregunta "�Dicha situacion ocurre varias veces (si/no)?: ") (nodo-si nodo-3) (nodo-no nodo-4))
(nodo (nombre nodo-3) (tipo respuesta) (respuesta "El nivel de probabilidad es PROBABLE"))
(nodo (nombre nodo-4) (tipo decision) (pregunta "�Dicha situacion ocurre esporadicamente (si/no)?: ") (nodo-si nodo-5) (nodo-no nodo-6))
(nodo (nombre nodo-5) (tipo respuesta) (respuesta "El nivel de probabilidad es OCASIONAL"))
(nodo (nombre nodo-6) (tipo decision) (pregunta "�Dicha situacion es romotamente posible (si/no)?: ") (nodo-si nodo-7) (nodo-no nodo-8))
(nodo (nombre nodo-7) (tipo respuesta) (respuesta "El nivel de probabilidad es RARA VEZ"))
(nodo (nombre nodo-8) (tipo respuesta) (respuesta "El nivel de probabilidad es IMPROBABLE"))
(nodo-actual nodo-0)
(estado pregunta)
(nodo-pregunta-respuesta)
)

;DEFRULES
(defrule pregunta-en-nodo-decision
?n <- (nodo-actual ?nombre)
	?e <- (estado pregunta)
	(nodo (nombre ?nombre)(tipo ?tipo)(pregunta ?pregunta)(respuesta ?respuesta))
	?p <- (nodo-pregunta-respuesta )
=>
	(retract ?e)
	(retract ?p)
	(if(eq ?tipo decision)then
       (assert (nodo-pregunta-respuesta (tipo ?tipo)(valor ?pregunta)))
	else
	(assert (nodo-pregunta-respuesta (tipo ?tipo)(valor ?respuesta)))
	)
)


(defrule procesa-si-en-nodo-decision
	?n <- (nodo-actual ?nombre)
	?o <- (opcion si)
	(nodo (nombre ?nombre)(tipo decision)(nodo-si ?n-si))
         =>
	(retract ?n)
	(retract ?o)
	(assert (nodo-actual ?n-si))
	(assert (estado pregunta))
)

(defrule procesa-no-en-nodo-decision
  	?n <- (nodo-actual ?nombre)
	?o <- (opcion no)
	(nodo (nombre ?nombre)(tipo decision)(nodo-no ?n-no))
        =>
	(retract ?n)
	(retract ?o)
	(assert (nodo-actual ?n-no))
	(assert (estado pregunta))
)
  



(defrule pregunta-de-nuevo
	?n <- (nodo-actual ?nombre)
	?o <- (opcion ?opcion)
	(nodo (nombre ?nombre)(tipo respuesta))
	?p <- (nodo-pregunta-respuesta )
=>
	(retract ?n)
	(retract ?p)
	(if(eq ?opcion si)then
		(assert (nodo-actual nodo-0))
		(assert (estado pregunta))
		(assert (nodo-pregunta-respuesta))
	else
		(assert (nodo-pregunta-respuesta (tipo salir)))
	)
	(retract ?o)
)