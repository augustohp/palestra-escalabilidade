backend web1 {
  .host = "192.168.42.20";
  .port = "80";
}
backend web2 {
  .host = "192.168.42.21";
  .port = "80";
}
director cluster round-robin {
  { .backend = web1; }
  { .backend = web2; }
}
sub vcl_recv {
  if (req.restarts == 0) {
    if (req.http.x-forwarded-for) {
      set req.http.X-Forwarded-For =
      req.http.X-Forwarded-For + ", " + client.ip;
    } else {
      set req.http.X-Forwarded-For = client.ip;
    }
  }

  set req.backend = cluster; # machine selection

  if (req.request != "GET" &&
      req.request != "HEAD" &&
      req.request != "PUT" &&
      req.request != "POST" &&
      req.request != "TRACE" &&
      req.request != "OPTIONS" &&
      req.request != "DELETE") {
     /* Non-RFC2616 or CONNECT which is weird. */
     return (pipe);
  }
  if (req.request != "GET" && req.request != "HEAD") {
    /* We only deal with GET and HEAD by default */
    return (pass);
  }
  #if (req.url == "/quote/random") {
  #   return (pass);
  #}
  if (req.http.Authorization || req.http.Cookie) {
    /* Not cacheable by default */
    return (pass);
  }
  return (lookup);
}
