select
    t.name as tabela,
    c.name as coluna
from
    sys.sysobjects    as t (nolock)
inner join sys.all_columns as c (nolock) on t.id = c.object_id and t.xtype = 'u'
where
    c.name like '%nrcalc%'
order by
    t.name asc