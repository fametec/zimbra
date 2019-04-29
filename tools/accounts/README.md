# README


Para filtrar contas com mais de 180 dias sem utilização, crie um filtro na interface administrativa do zimbra, exemplo: 



    (&(|(!(zimbraLastLogonTimestamp=*))(zimbraLastLogonTimestamp<=###JSON:{func: ZaSearch.getTimestampByDays, args:[-180]}###)))



