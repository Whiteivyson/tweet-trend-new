FROM openjdk:17
ADD jarstaging/com/valaxy/demo-workshop/2.1.5/demo-workshop-2.1.3.jar ttrend.jar 
ENTRYPOINT [ "java", "-jar", "ttrend.jar"]
EXPOSE 8000