USE webnative;
select path.Path, file.FileName from file, path where FileName LIKE 'MPLS_021521%' and path.PathID=file.PathID;