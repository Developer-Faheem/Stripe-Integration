const String stripePublishableKey =
    "pk_test_51PhRbt2N8JiCSbuUHNHQSy6V9PJfFNetORhIZld0HukJA6Mlzcfxb0W4HMLBu5cZ3igbYWtY6PVeoejqOwiuYw1V00WUlgyshJ";
const String stripeSecretKey =
    "sk_test_51PhRbt2N8JiCSbuUMuoUZzSndRbhfo3iPrBjeNhf6yRNUUPIrvbChWcKaYXPhGIPsfZWPkJAHciHBe66A7uVn7Vn00cxWAssgE";

//keeping tyyhe secret key in the frontend code is not good practice its just done,
//only for testing purpose, it is usually kept in the cloud function in firebase 
//it means that our payement intent is being made within our server and returned to us
