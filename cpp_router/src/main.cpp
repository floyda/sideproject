#include <iostream>
#include <process.h>

#include "wampcc/wampcc.h"
#include "router.hpp"

int main()
{
    try {
        std::promise<void> can_exit;

        auto logger = wampcc::logger::stream(wampcc::logger::lockable_cout,
                                         wampcc::logger::levels_upto(wampcc::logger::eDebug),
                                         true);
        
        wampcc::config conf;
        conf.ssl.enable = false;
        // conf.ssl.certificate_file = argv[1];
        // conf.ssl.private_key_file = argv[2];

        std::unique_ptr<wampcc::kernel> the_kernel(
            new wampcc::kernel(conf, logger));
        
        logger.write(wampcc::logger::eInfo, wampcc::package_string(), __FILE__, __LINE__);

        /* Create an embedded wamp router. */
        wampcc::wamp_router router(the_kernel.get());

        wampcc::auth_provider auth = wampcc::auth_provider::no_auth_required();
        wampcc::wamp_router::listen_options listen_opts;
        listen_opts.ssl = false;
        listen_opts.service = "55888";
        auto fut = router.listen(auth, listen_opts);

        if (fut.wait_for(std::chrono::milliseconds(250)) != std::future_status::ready)
        {
            throw std::runtime_error("timeout during router listen");
        }

        if (auto ec = fut.get())
        {
            throw std::runtime_error("listen failed: err " +
                                std::to_string(ec.os_value()) + ", " +
                                ec.message());
        }
        

        logger.write(wampcc::logger::eInfo,
                    "ssl socket listening on 55888",
                    __FILE__, __LINE__);

        router.callable("host_realm", "pid",
            [](wampcc::wamp_router&, wampcc::wamp_session& caller, wampcc::call_info info) {
                caller.result(info.request_id, {getpid()});
            });

        /* Suspend main thread */
        can_exit.get_future().wait();
    }
    catch(const std::exception& e) 
    {
        std::cout << e.what() << std::endl;
        return 1;
    }
}