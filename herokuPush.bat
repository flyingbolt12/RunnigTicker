heroku container:push web --app runningticker
heroku container:release web --app runningticker
heroku logs --tail --app runningticker