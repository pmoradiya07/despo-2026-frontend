'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "637e6e10ce78747f9a54de24a95fbeb9",
"assets/AssetManifest.bin.json": "93a0e7d244bcbf4a79c04b6caf2667ae",
"assets/assets/fonts/Jersey10-Regular.ttf": "6f7ad3b500e63bf31a8fc20646ab4504",
"assets/assets/images/abhas.jpg": "cfc3419624e44c788b057fc63712dc34",
"assets/assets/images/admin.png": "25f6975bbb5465808729c018b5428f8f",
"assets/assets/images/arnav.jpg": "57bf4a72ff9de45066c02cb09d9a2fba",
"assets/assets/images/bg_image.png": "344633fc5c0d99bd4495b2785cfc6268",
"assets/assets/images/hatim.jpg": "0c1df61629585e525b9c0bd90233a007",
"assets/assets/images/insta.png": "5b0db1c1da7f23d73ab9c580cbd598d0",
"assets/assets/images/kartik.jpg": "f72f3c81ac323bf2e027fe94eb973540",
"assets/assets/images/kirti.jpg": "2c75ca051b3b0ee81adbc8d1e300e678",
"assets/assets/images/liveEvents.png": "52c0d2ecf373fc5e0a4c54e328a80421",
"assets/assets/images/logout.png": "5e9dbd7a7978c7a3fe45b663751dea76",
"assets/assets/images/Map.png": "7f8ec16f2c9aeed5331f32f0f4e5f3f8",
"assets/assets/images/notifications.png": "a75adc3a7bdbcd6b6ec0a6617715493c",
"assets/assets/images/outsignin.png": "d81b0ba4705cbecb2efc091889e82afd",
"assets/assets/images/profilecard.png": "6164559a23ffb74bbf99d51332532f28",
"assets/assets/images/sabhay.jpg": "258b5d0a6fc2fef0e857dcb00f318c34",
"assets/assets/images/shadowcover.png": "3c01c0fd2628e71c5f6f50e33c7bed04",
"assets/assets/images/signin.png": "f16285011f866b6a3fb0c3e8cec9e2ae",
"assets/assets/images/welcomedespo.png": "cf057adee6b95c915756e0138b2235de",
"assets/assets/nav/home.png": "ace5dce72e3eab35a97ac060632ec0f9",
"assets/assets/nav/home_active.png": "19c8a139dfa9ec4c93347c0531946152",
"assets/assets/nav/live.png": "6e12b62663ae19a6316ad884a3089fd8",
"assets/assets/nav/live_active.png": "d817d853b885ee6548ba7746d5e178e8",
"assets/assets/nav/map.png": "145f8f4916168616cb5bb158c2eb59fc",
"assets/assets/nav/map_active.png": "f63feb6e0b038cd3e4c2aabdc5e850fe",
"assets/assets/nav/notifs.png": "cafa8584fb36dfacd77bd8555570b8a7",
"assets/assets/nav/notifs_active.png": "172a10ed1835449b761f0604bc69d271",
"assets/assets/nav/profile.png": "5ad9018488ad6f1e15d9febb047f9652",
"assets/assets/nav/profile_active.png": "a6236495f09cad87cd05423ab9bba653",
"assets/assets/splash/d_body.png": "e7d57f99f15eac4ad97bacd2dde80aa8",
"assets/assets/splash/flame.png": "aa0a748050e6b2976fc963b2eb8996ee",
"assets/assets/splash/splashBackground.png": "6f1a300575271fe553812617d4241caa",
"assets/assets/svg/despo_logo.svg": "4c2b396129967494979ba07f62c7f8fd",
"assets/FontManifest.json": "db594e474abd550608de1043fd5d05ec",
"assets/fonts/MaterialIcons-Regular.otf": "f5c4691d614721f6d467a69e07c08797",
"assets/NOTICES": "b7070da7ecf9d652b313b50732a5a304",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "697b1635c467442bd582b4664f9d7a87",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c9f51ad97a22b405723977f47445f209",
"/": "c9f51ad97a22b405723977f47445f209",
"main.dart.js": "41dc808a0faf23831456bf0cbf15a3cf",
"manifest.json": "a7639166323f417d6002781d559d8398",
"version.json": "edba8934830aad40c12735882d8a56e9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
