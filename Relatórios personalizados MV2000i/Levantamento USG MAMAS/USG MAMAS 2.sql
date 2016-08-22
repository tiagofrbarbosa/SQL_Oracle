SELECT A.CD_ATENDIMENTO,
       A.CD_PACIENTE,
       TO_CHAR(PM.DT_PRE_MED,'DD/MM/YYYY'),
       P.NM_PRESTADOR,
       E.DS_ESPECIALID,
       TP.DS_TIP_PRESC
FROM PRE_MED PM,
     ITPRE_MED ITPM,
     TIP_PRESC TP,
     ATENDIME A,
     PRESTADOR P,
     ESPECIALID E
WHERE 
     PM.DT_PRE_MED BETWEEN '01-06-2014' AND '20-08-2015'
     AND PM.CD_PRE_MED = ITPM.CD_PRE_MED
     AND A.CD_ATENDIMENTO = PM.CD_ATENDIMENTO
     AND ITPM.CD_TIP_PRESC = TP.CD_TIP_PRESC
     AND A.CD_PRESTADOR = P.CD_PRESTADOR
     AND E.CD_ESPECIALID = A.CD_ESPECIALID
     AND A.CD_MULTI_EMPRESA = 1
     AND TP.CD_TIP_PRESC = 32830
     AND A.CD_PACIENTE IN(
                            SELECT IT.CD_PACIENTE
                              FROM 
                              IT_AGENDA_CENTRAL IT,
                              AGENDA_CENTRAL AC
                                  WHERE IT.CD_ITEM_AGENDAMENTO IN (62,343) 
                                  AND IT.CD_AGENDA_CENTRAL = AC.CD_AGENDA_CENTRAL
                                  AND AC.DT_AGENDA BETWEEN '01-01-2015' AND '01-07-2015'
                                  AND AC.CD_MULTI_EMPRESA = 1
                          )
      ORDER BY A.CD_PACIENTE