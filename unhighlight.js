/*!
UnHighlight - Remove "?highlight=..." from urls
Copyright (C) 2020  Justin Bassett

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// Based on Pure URL by VEG: https://addons.mozilla.org/en-US/firefox/addon/pure-url/
// which is licensed under GPL-v3, as is this extension.

browser.webRequest.onBeforeRequest.addListener(
    function (req) {
        // Note: `return;` causes the listener to apply no action. If we returned a redirect to the
        // URL unmodified, then this listener would be triggered again due to the redirect in an
        // infinite loop.

        // If the API is unsupported, don't strip the highlight, and therefore don't redirect.
        if (typeof URL === undefined || typeof URLSearchParams === undefined) return;
        const url = new URL(req.url)
        // If there is no highlight to strip, don't redirect.
        if (!url.searchParams.has('highlight')) return;
        // Delete ?highlight=...
        url.searchParams.delete('highlight')
        // Redirect to the modified URL.
        return { redirectUrl: url.toString() }
    },
    // If there is a 'highlight' query parameter, then it should appear somewhere after the '?'.
    { urls: ['https://*/*?*highlight*', 'http://*/*?*highlight*'], types: ['main_frame'] },
    // We want to be able to do redirects.
    ['blocking']);
