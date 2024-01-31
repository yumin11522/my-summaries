
export INSTALL_PATH=/home/numax/workspace/freeswitch/depen 

export PKG_CONFIG_PATH=/home/numax/workspace/freeswitch/depen/lib/pkgconfig:/home/numax/workspace/freeswitch/depen/lib64/pkgconfig:/usr/local/lib/pkgconfig:



./GCasServer -base "${INSTALL_PATH}" \
    -conf "${INSTALL_PATH}"/etc/freeswitch \
    -log "${INSTALL_PATH}"/log \
    -run "${INSTALL_PATH}"/run \
    -db "${INSTALL_PATH}"/db \
    -mod "${INSTALL_PATH}"/lib/freeswitch/mod \
    -htdocs "${INSTALL_PATH}"/htdocs \
    -scripts "${INSTALL_PATH}"/scripts \
    -temp "${INSTALL_PATH}"/temp \
    -grammar "${INSTALL_PATH}"/grammar \
    -certs "${INSTALL_PATH}"/certs \
    -recordings "${INSTALL_PATH}"/recordings \
    -storage "${INSTALL_PATH}"/storage \
    -cache "${INSTALL_PATH}"/cache \
    -sounds "${INSTALL_PATH}"/share/freeswitch/sounds \
    -u root -g root \
    -nonat
	
	
	
	
JSSIP 需要在呼叫前，设置 RTCP-MUX 为协商
const session = this._ua.call(uri,
{
	// pcConfig         : { iceServers: [{ urls: [' '] }] },
	pcConfig:
	{
		rtcpMuxPolicy: 'negotiate'
	},
	mediaConstraints:
	{
		audio: true,
		video: true
	},
	rtcOfferConstraints:
	{
		offerToReceiveAudio: 1,
		offerToReceiveVideo: 1
	}
});