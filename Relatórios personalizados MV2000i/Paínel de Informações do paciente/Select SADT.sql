
--pega procedimentos solicitados na SADT, a parir do atendimento

SELECT VIRD.DESC_RESPOSTA 
FROM VDIC_ITEM_RESPOSTA_DOCUMENTO  VIRD
WHERE VIRD.REGISTRO_DOCUMENTO IN(
                                SELECT VDIC_RESPOSTA_DOCUMENTO.REGISTRO_DOCUMENTO 
                                FROM VDIC_RESPOSTA_DOCUMENTO,
                                     ATENDIME
                                WHERE ATENDIME.CD_ATENDIMENTO = VDIC_RESPOSTA_DOCUMENTO.ATENDIMENTO
                                AND ATENDIME.CD_MULTI_EMPRESA = 1
                                AND VDIC_RESPOSTA_DOCUMENTO.DOCUMENTO_PRONTUARIO IN(111,294)
                                AND ATENDIME.CD_ATENDIMENTO = 2971817
                             )
AND VIRD.PERGUNTA_DOCUMENTO IN(6532,6535,6538,6541,6544)
ORDER BY VIRD.PERGUNTA_DOCUMENTO