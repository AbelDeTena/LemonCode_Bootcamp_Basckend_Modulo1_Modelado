--Listar las pistas (tabla Track) con precio mayor o igual a 1�
SELECT t.TrackID, t.Name, t.AlbumId, t.UnitPrice FROM Track AS t WHERE UnitPrice >= 1;
--Listar las pistas de m�s de 4 minutos de duraci�n
SELECT t.TrackID, t.Name, t.AlbumId, t.Milliseconds FROM Track AS t WHERE t.Milliseconds > 240000;
--Listar las pistas que tengan entre 2 y 3 minutos de duraci�n
SELECT t.TrackID, t.Name, t.AlbumId, t.Milliseconds FROM Track AS t WHERE t.Milliseconds BETWEEN 120000 AND 180000;
--Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT t.TrackID, t.Name, t.AlbumId, t.Composer FROM Track AS t WHERE t.Composer LIKE '%Mercury%';
--Calcular la media de duraci�n de las pistas (Track) de la plataforma
SELECT AVG(t.Milliseconds) / (60 * 1000) AS DuracionPromedioEnMinutos FROM Track AS t;
--Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT c.FirstName, c.LastName, c.Country FROM Customer AS c WHERE c.Country IN ('Brazil', 'Canada', 'USA');
--Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT t.TrackID, t.Name, t.AlbumId, t.AlbumId FROM Track AS t 
JOIN Album AS a ON t.AlbumId = a.AlbumId 
JOIN Artist AS ar ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'Queen';
--Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT t.TrackID, t.Name, t.AlbumId, t.AlbumId FROM Track AS t 
JOIN Album AS a ON t.AlbumId = a.AlbumId 
JOIN Artist AS ar ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'Queen' AND t.Composer LIKE '%David Bowie%';
--Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT t.TrackID, t.Name, t.Composer FROM Track AS t 
JOIN PlaylistTrack as plt ON t.TrackId = plt.TrackId
JOIN Playlist AS pl ON plt.PlaylistId = pl.PlaylistId
WHERE pl.Name = 'Heavy Metal Classic'
--Listar las playlist junto con el n�mero de pistas que contienen
SELECT p.Name, COUNT(plt.TrackID) AS Contiene
FROM Playlist AS p
JOIN PlaylistTrack AS plt ON p.PlaylistID = plt.PlaylistID
GROUP BY p.PlaylistID, p.Name;
--Listar las playlist (sin repetir ninguna) que tienen alguna canci�n de AC/DC
SELECT DISTINCT p.Name, AR.Name FROM Playlist AS p
JOIN PlaylistTrack AS plt ON p.PlaylistID = plt.PlaylistID
JOIN Track AS t ON t.TrackId = plt.TrackId
JOIN Album AS a ON t.AlbumId = a.AlbumId
JOIN Artist AS ar ON ar.ArtistId = a.ArtistId
WHERE ar.Name = 'AC/DC' 
--Listar las playlist que tienen alguna canci�n del artista Queen, junto con la cantidad que tienen
SELECT DISTINCT p.Name, AR.Name, t.Name FROM Playlist AS p
JOIN PlaylistTrack AS plt ON p.PlaylistID = plt.PlaylistID
JOIN Track AS t ON t.TrackId = plt.TrackId
JOIN Album AS a ON t.AlbumId = a.AlbumId
JOIN Artist AS ar ON ar.ArtistId = a.ArtistId
WHERE ar.Name = 'Queen' 
--Listar las pistas que no est�n en ninguna playlist
SELECT DISTINCT t.Name FROM Track AS t
LEFT JOIN PlaylistTrack AS plt ON plt.TrackId = t.TrackId
WHERE plt.TrackId IS NULL;
--Listar los artistas que no tienen album
SELECT DISTINCT ar.Name, a.Title AS Album FROM Artist AS ar
LEFT JOIN Album AS a ON a.ArtistId = ar.ArtistId
WHERE a.Title IS NULL
--Listar los artistas con el n�mero de albums que tienen
SELECT ar.Name, COUNT(a.AlbumId) AS NumeroDeAlbums FROM Artist AS ar
LEFT JOIN Album AS a ON a.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY NumeroDeAlbums DESC;

