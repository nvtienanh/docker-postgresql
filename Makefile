POSTGRES_TAG := 9.6-hive2.3.4
build:
	docker build -t nvtienanh/postgresql:$(POSTGRES_TAG) ./
push:
	docker push nvtienanh/postgresql:$(POSTGRES_TAG)
