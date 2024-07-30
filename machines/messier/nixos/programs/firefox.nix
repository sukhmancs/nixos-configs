#
# Firefox with custom policies. Visit this Url for more info: https://mozilla.github.io/policy-templates/#blockaboutconfig
# Some options:
#   "Locked" means that the user can not change that value using FireFox UI.
#
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Cookies = {
        # Disable Cookies, Delete cookies after session
        Allow = [
          "https://chat.openai.com/"
          "https://gemini.google.com/"
          "https://github.com/"
          "https://feedly.com/"
          "https://huggingface.co/"
          "https://login.microsoftonline.com/"
          "https://mycanvas.mohawkcollege.ca/"
          "https://mymohawk.mohawkcollege.ca/"
          "https://careerready.mohawkcollege.ca"
          "http://beanthere.free.nf"
          "https://sukhmansingh.netlify.app"
        ];
        AllowSession = ["https://reddit.com"];
        Default = false;
        AcceptThirdParty = "never";
        RejectTracker = true;
        Locked = true;
        Behavior = "reject-foreign";
        BehaviorPrivateBrowsing = "reject";
      };
      OfferToSaveLoginsDefault = false; # Disable save Logins
      PictureInPicture = {
        # Disable picture in picture
        Enabled = false;
        Locked = true;
      };
      FirefoxHome = {
        # Custom FireFox Home
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      Handlers = {
        # What application or url should be opened based on MIME TYPE
        mimeTypes = {
          "application/msword" = {
            action = "useSystemDefault";
            ask = true;
          };
        };
        schemes = {
          mailto = {
            action = "useHelperApp";
            ask = true;
            handlers = [
              {
                name = "Gmail";
                uriTemplate = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
              }
            ];
          };
        };
      };
      ManualAppUpdateOnly = true; # Don't pop up "Update Firefox" message
      PasswordManagerEnabled = false;
      Preferences = {
        "accessibility.force_disabled" = {
          Value = 1;
          Status = "default";
          Type = "number";
        };
        "browser.tabs.warnOnClose" = {
          Value = false;
          Status = "locked";
        };
        "ui.key.menuAccessKeyFocuses" = {
          Value = false;
          Status = "locked";
        };
        "toolkit.legacyUserProfileCustomizations.stylesheets" = {
          Value = true;
        };
      };
      #   SanitizeOnShutdown = {
      #     # Delete data on quit
      #     Cache = true;
      #     Cookies = true;
      #     Downloads = false;
      #     FormData = true;
      #     History = false;
      #     Sessions = false;
      #     SiteSettings = false;
      #     OfflineApps = true;
      #     Locked = true;
      #   };
      SearchEngines = {
        # Prevent installing custom search engines
        PreventInstalls = true;
      };
      UserMessaging = {
        # Disable FireFox from showing messages
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = false;
      };
      GoToIntranetSiteForSingleWordEntryInAddressBar = true;
      BlockAboutConfig = true; # Disable access to about:config page
      BlockAboutSupport = true;
      #      BlockAboutProfiles = true;
      BlockAboutAddons = true;
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisablePocket = true;
      DisableSafeMode = false;
      DisableSecurityBypass = {
        InvalidCertificate = false;
        SafeBrowsing = false;
      };
      CaptivePortal = false;
      DontCheckDefaultBrowser = true;
      DisplayMenuBar = "never";
      DisableTelemetry = true;
      DownloadDirectory = "~/Downloads/Firefox";
      WebsiteFilter = {
        Block = ["file://*/*"];
        #Exceptions = ["http://example.org/*"];
      };
      DNSOverHTTPS = {
        # Disable DNS queries over https because I am using dnscryptproxy on system.
        Enabled = false;
        Locked = true;
      };
      EncryptedMediaExtensions = {
        # Disable DRM Content
        Enabled = false;
        Locked = true;
      };
      ExtensionSettings = {
        # "*" = {
        #   # Default configuration for all other extensions (i.e Block installation of all other extensions)
        #   blocked_install_message = "You do not have permissions to install extensions.
        #   Please change the FireFox policy in your NixOS configurations.";
        #   installation_mode = "blocked";
        #   allowed_types = ["extension"];
        # };
        "uBlock0@raymondhill.net" = {
          # UBlock Origin
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # "extension@one-tab.com" = {
        #   # Onetab
        #   installation_mode = "allowed";
        # };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          # Vimium
          installation_mode = "allowed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
        };
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
      };
      Homepage = {
        # Default HomePage settings
        URL = "about:home";
        Locked = true;
        StartPage = "previous-session";
      };
      NetworkPrediction = false; # stop network prefeching
      OverridePostUpdatePage = ""; # do not show any page after firefox upgrade
      PDFjs = {
        # enable default firefox pdf viewer
        Enabled = true;
        EnablePermissions = true; # owner documents permissions
      };
      Permissions = {
        Camera = {
          #          Allow = ["https://example.org","https://example.org:1234"];
          #          Block = ["https://example.edu"];
          BlockNewRequests = true;
          Locked = true;
        };
        Microphone = {
          #          Allow = ["https://example.org"];
          #          Block = ["https://example.edu"];
          BlockNewRequests = true;
          Locked = true;
        };
        Location = {
          Allow = ["https://maps.google.com/"];
          #          Block = ["https://example.edu"];
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          #          Allow = ["https://example.org"];
          #          Block = ["https://example.edu"];
          BlockNewRequests = true;
          Locked = true;
        };
        Autoplay = {
          #          Allow = ["https://example.org"];
          #          Block = ["https://example.edu"];
          Default = "block-audio-video";
          Locked = true;
        };
      };
    };
  };
}
