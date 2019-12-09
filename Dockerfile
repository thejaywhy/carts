FROM mcr.microsoft.com/java/maven:8u232-zulu-debian9

WORKDIR /opt/carts

COPY . .

RUN mvn package \
    && mv target/carts.jar /run \
    && rm -rf *

EXPOSE 80

CMD java -jar carts.jar --port=80
