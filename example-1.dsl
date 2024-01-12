workspace "NDP example" "Example modelling the entire NDP system" {
    
    !docs workspace-docs

    model {
        healthStaff = person "Health & Social Care Staff"
        vaccinators = person "Vaccinators"

        vmt = softwareSystem "VMT"
        twm = softwareSystem "Turas Weight Management"

        ndp = group "NDP" {
            empi = softwareSystem "EMPI" {
                testDatabase = container "Test Patient Database" "Only includes test patients" "Amazon S3 bucket" "Database"
                empiApi = container "EMPI API" "Allows for looking patients up by CHI or demographic search" "Node / Express" {
                    -> testDatabase "Requests if not found in new CHI" 
                }
               
            }
            authN = softwareSystem "AuthN"
            respect = softwareSystem "RESPECT"
            cdr = softwareSystem "CDR"
        }

        newChi = softwareSystem "NSS New CHI"

        

        // Relationships 
        healthStaff -> vmt "Uses"
        vaccinators -> twm "Uses"
        vmt -> empiApi "Retrieves patient demographics"
        twm -> empiApi "Retrieves patient demographics"
        empiAPI -> authN "Requests authentication"
        respect -> authN "Requests authentication"
        respect -> cdr "Retrieves and persists data"
        empiAPI -> newChi "Retrieves patient demographics"
      

      
    }

        // NDP = group "NDP" {
           
        //     AWS = softwareSystem "AWS" {

        //         // VPCProducts = group "VPC: Products" {

        //         //     CRE = container "CRE" {
        //         //         softwareSystem product "product" {}
        //         //     }




        //         // }

        //         // VPCPlatform = group "VPC: Platform" {

                    


        //         // }


        //     }
            
        // }

        
        
        


        // redefining relationships with new elements
        // staff -> VPCProducts "use"
        // citizens -> VPCProducts "use"
    

    views {


// deployment VPCProducts live {
//             include *
//             autoLayout lr
//         }
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext empi "SystemContextEMPI" {
            include *
            //animation {
                //internetBankingSystem
                //customer
                //mainframe
                //email
            //}
            autoLayout
        }

            container empi "Containers" {
            include *
            // animation {
            //     customer mainframe email
            //     webApplication
            //     singlePageApplication
            //     mobileApp
            //     apiApplication
            //     database
            // }
            autoLayout
        }

        // systemcontext VPCPlatform "SystemContextPlatform" {
        //     include *
        //     //animation {
        //         //internetBankingSystem
        //         //customer
        //         //mainframe
        //         //email
        //     //}
        //     autoLayout
        // }
        
    

        // component apiApplication "Components" {
        //     include *
        //     animation {
        //         singlePageApplication mobileApp database email mainframe
        //         signinController securityComponent
        //         accountsSummaryController mainframeBankingSystemFacade
        //         resetPasswordController emailComponent
        //     }
        //     autoLayout
        // }

        theme default
    }

}