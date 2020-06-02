SELECT *
INTO BlobOutput
FROM IotInput

SELECT 
    System.Timestamp AS WindowEnd,
    AVG(temperature) as Temperature
INTO PowerBIOutput
FROM IotInput
GROUP BY
	TumblingWindow(second, 2)
