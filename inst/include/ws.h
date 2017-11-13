#include <Rcpp.h>

#ifdef _WIN32
#pragma comment( lib, "ws2_32" )
#include <WinSock2.h>
#endif

#include <assert.h>
#include <stdio.h>
#include <string>
#include <iostream>
#include <thread>
#include <chrono>
#include <condition_variable>

#include "easywsclient.hpp"

typedef struct _chromeWs chromeWs;
typedef chromeWs *chromeWsPtr;
struct _chromeWs {
  easywsclient::WebSocket::pointer ws;
  std::string response;
  bool ready;
};

inline void finaliseWs(chromeWsPtr ws) {}

typedef Rcpp::XPtr<chromeWs,Rcpp::PreserveStorage,finaliseWs> XPtrWs;
