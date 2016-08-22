SELECT
DS_GRUPO_PROCEDIMENTO
           , TP_UNIDADE  
           , CD_SUB_GRUPO_PROCEDIMENTO
           , DS_SUB_GRUPO_PROCEDIMENTO
           , CD_ORGANIZA_GRUPO_PROCEDIMENTO
           , DS_ORGANIZA_GRUPO_PROCEDIMENTO
           , CD_PROCEDIMENTO
           , DS_PROCEDIMENTO
           , Sum(QT_LANCADA)                                          QT_LANCADA
           , Sum(VL_SERVICO_AMBULATORIAL)              VL_SERVICO_AMBULATORIAL
           , Sum(VL_SERVICO_ANESTESIA)                      VL_SERVICO_ANESTESIA
--           , Sum(VL_SERVICO_PROFISSIONAL)                VL_SERVICO_PROFISSIONAL
           , Sum(P_VL_SERVICO_PROFISSIONAL_AMB)     VL_SERVICO_PROFISSIONAL
           , Sum(VL_TOTAL_AMBULATORIAL)                   VL_TOTAL_AMBULATORIAL
           , VL_UNITARIO
--, Sum(VL_UNITARIO)  / Decode(Sum(QT_LANCADA),0,1,Sum(QT_LANCADA))    VL_UNITARIO
    From Dbamv.V_FFAS_Fat_Global_p321
 Where 1 = 1
            &CF_SETOR
             &CF_W_Fat_Sia
             &CF_W_Decendio
             &CF_W_Sobra
             &CF_W_Remessa
             &CF_W_Periodo
             &CF_W_TP_Lcto
             &CF_W_Tip_Ate
             &CF_W_Grupo_Procedimento
           --&CF_W_Tipo_Unidade
             &CF_W_Sub_Grupo_Procedimento
             &CF_W_Organiza_Grupo_Proc
             &CF_W_Tipo_Procedimento
             &CF_AUTORIZADOS
             &CF_W_ORTESEPROTESE --Pda 335944
--             &CF_W_NAOFATURADO  --PDA 342607
             &CF_REAPRESENTACAO
             &CF_PROCEDIMENTOS
             &CF_PACOTE
Group By CD_GRUPO_PROCEDIMENTO
         , DS_GRUPO_PROCEDIMENTO
         , CD_SUB_GRUPO_PROCEDIMENTO
         , TP_UNIDADE  
         , DS_SUB_GRUPO_PROCEDIMENTO
         , CD_ORGANIZA_GRUPO_PROCEDIMENTO
         , DS_ORGANIZA_GRUPO_PROCEDIMENTO
         , CD_PROCEDIMENTO
         , DS_PROCEDIMENTO
        , VL_UNITARIO
Order By CD_GRUPO_PROCEDIMENTO
            , CD_SUB_GRUPO_PROCEDIMENTO
            , CD_ORGANIZA_GRUPO_PROCEDIMENTO
            , TP_UNIDADE  
              &CF_Order_By