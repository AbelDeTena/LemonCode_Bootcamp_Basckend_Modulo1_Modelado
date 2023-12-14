--Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente
SELECT t.Name, COUNT(plt.PlaylistId) AS NumeroDeVecesEnPlaylists FROM Track AS t 
JOIN PlaylistTrack AS plt ON plt.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY NumeroDeVecesEnPlaylists DESC;
--Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras)
SELECT t.Name, SUM(il.Quantity) AS NumeroDeVentas FROM Track AS t 
JOIN InvoiceLine AS il ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY NumeroDeVentas DESC;
--Listar los artistas más comprados
SELECT ar.Name AS NombreArtista, SUM(il.Quantity) AS NumeroDeVentas FROM Artist AS ar
LEFT JOIN Album AS a ON a.ArtistId = ar.ArtistId
LEFT JOIN Track AS t ON t.AlbumId = a.AlbumId
LEFT JOIN InvoiceLine AS il ON il.TrackId = t.TrackId
GROUP BY ar.ArtistId, ar.Name
ORDER BY NumeroDeVentas DESC;
--Listar las pistas que aún no han sido compradas por nadie
SELECT t.Name FROM Track AS t 
LEFT JOIN InvoiceLine AS il ON il.TrackId = t.TrackId
WHERE il.Quantity IS NULL
--Listar los artistas que aún no han vendido ninguna pista
SELECT ar.Name AS NombreArtista FROM Artist AS ar
LEFT JOIN Album AS a ON a.ArtistId = ar.ArtistId
LEFT JOIN Track AS t ON t.AlbumId = a.AlbumId
LEFT JOIN InvoiceLine AS il ON il.TrackId = t.TrackId
GROUP BY ar.ArtistId, ar.Name
HAVING SUM(il.Quantity) IS NULL;

