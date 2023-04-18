export const storeSession = async () => {
    let res = await fetch('/api/session')
    let token = res.headers.get('X-CSRF-Token')
    //set it inside sessionStorage object
    sessionStorage.setItem('X-CSRF-Token', token)
    let data = await res.json();
    sessionStorage.setItem('currentUser', JSON.stringify(data.user))
}