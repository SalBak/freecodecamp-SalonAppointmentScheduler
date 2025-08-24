#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n--- Salon Services --"
SERVICES=$($PSQL "select service_id,name from services")
CLEAN_SER(){
  echo -e "\nYou have selected Cleaning service:"
  echo -e "\nPlease enter your Phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nPlease enter your Name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(phone,name) values ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nPlease enter your Service time:"
  read SERVICE_TIME
  #get service id
  SERV_ID=$($PSQL "SELECT service_id from services where name='Cleaning'")
  SERV_NAME=$($PSQL "SELECT name from services where service_id=$SERV_ID")
  #GET CUSTOMER ID
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERV_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERV_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
FOOD_SER(){
  echo -e "\nYou have selected Food service"
  echo -e "\nPlease enter your Phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nPlease enter your Name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(phone,name) values ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nPlease enter your Service time:"
  read SERVICE_TIME
  #get service id
  SERV_ID=$($PSQL "SELECT service_id from services where name='Food'")
  SERV_NAME=$($PSQL "SELECT name from services where service_id=$SERV_ID")
  #GET CUSTOMER ID
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERV_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERV_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
DRINK_SER(){
  echo -e "\nYou have selected Drinks service"
  echo -e "\nPlease enter your Phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nPlease enter your Name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(phone,name) values ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi
  echo -e "\nPlease enter your Service time:"
  read SERVICE_TIME
  #get service id
  SERV_ID=$($PSQL "SELECT service_id from services where name='Drinks'")
  SERV_NAME=$($PSQL "SELECT name from services where service_id=$SERV_ID")
  #GET CUSTOMER ID
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERV_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERV_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
MAIN_SER() {
  echo -e "\nHere are the services we have available:"
  echo -e "$SERVICES" | while read SER_ID BAR NAME
  do
    echo -e "$SER_ID) $NAME"
  done
  #echo -e "\n1. Rent a bike\n2. Return a bike\n3. Exit"
  read SERVICE_ID_SELECTED 
  case $SERVICE_ID_SELECTED in
  1) CLEAN_SER ;;
  2) FOOD_SER ;;
  3) DRINK_SER ;;
  *) MAIN_SER "Please enter a valid option." ;;
  esac
}

MAIN_SER