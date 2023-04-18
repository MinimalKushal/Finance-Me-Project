FROM openjdk:11
COPY target/*.jar FinanceMe.jar
CMD ["java", "-jar", "FinanceMe.jar"]
